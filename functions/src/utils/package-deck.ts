/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import JSZip from "jszip";
import {bucket, firestore} from "../init";
import {withId} from "./with-id";

export async function deleteDeckPackage(pId: string) {
  try {
    await bucket.deleteFiles({
      prefix: `decks/${pId}`,
    });
  } catch {
    console.log("no files");
  }
}

export async function createDeckPackage(lang: string, pId: string) {
  const deck = {} as any;
  const pRef = await firestore
      .doc(`languages/${lang}/packs/${pId}`)
      .get()
      .then((d) => {
        deck.pack = withId(d);
        return d.ref;
      });

  const cards = await pRef.collection("cards").get().then((s) => s.docs);
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