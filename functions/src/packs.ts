/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable require-jsdoc */

import JSZip from "jszip";
import * as functions from "firebase-functions";
import {firestore, storage} from "firebase-admin";
import {isUpdated} from "./utils/update-check";
import {withId} from "./utils/with-id";


const bucket = storage().bucket();
const db = firestore();

export const packageDecks = functions
    .region("europe-central2")
    .firestore.document("languages/{lang}/packs/{pID}")
    .onWrite(async (change, context) => {
      const {lang, pID} = context.params;
      if (change.before.exists) {
        try {
          await bucket.deleteFiles({
            prefix: `decks/${pID}`,
          });
        } catch {
          console.log("no files");
        }
      }
      if (change.after.exists) {
        if (isUpdated(change.after.data(), change.before.data())) {
          await createDeckPackage(lang, pID);
          await db.doc(`languages/${lang}`)
              .update({
                "lastUpdated": firestore.FieldValue.serverTimestamp(),
              });
        }
      }
    });


async function createDeckPackage(lang: string, pId: string) {
  const deck = {} as any;
  const pRef = await db
      .doc(`languages/${lang}/packs/${pId}`)
      .get()
      .then((d) => {
        deck.pack = withId(d);
        return d.ref;
      });

  const cards = await pRef.collection("cards")
      .orderBy("order")
      .get()
      .then((s) => s.docs);
  deck.cover = withId(cards.find((d) => d.id == deck.pack.coverId)!);
  deck.cards = cards
      .filter((d) => d.id != deck.pack.coverId)
      .map((d) => withId(d));

  const translations = { } as any;
  for (const t of await pRef
      .collection("translations")
      .get()
      .then((s) => s.docs.map((d) => d.data()!))) {
    const l = t.language;
    if (!translations[l]) translations[l] = {};
    translations[l][t.cardId] = t.text;
  }

  const zip = new JSZip();
  zip.file("deck.json", JSON.stringify(deck));
  for (const c of cards) {
    const {imagePath, audioPath} = c.data()!;
    if (audioPath) {
      try {
        await bucket.file(`static/audios/${lang}/${audioPath}`)
            .download()
            .then(([data]) => {
              zip.file(audioPath, data);
            });
      } catch {
        console.log("missing", audioPath);
      }
    }
    if (imagePath) {
      try {
        await bucket.file(`static/images/${imagePath}`)
            .download()
            .then(([data]) => {
              zip.file(imagePath, data);
            });
      } catch {
        console.log("missing", imagePath);
      }
    }
  }

  await bucket
      .file(`decks/${pId}/${pId}.zip`)
      .save(
          await zip.generateAsync({type: "nodebuffer"}),
          {resumable: false, gzip: "auto"});
  for (const [l, t] of Object.entries( translations)) {
    await bucket
        .file(`decks/${pId}/${l}.json`)
        .save(JSON.stringify(t), {resumable: false, gzip: "auto"});
  }
}
