/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import JSZip from "jszip";
import {bucket, firestore} from "./init";

const lang = "east circassian";
const packId = "UVueyt5qr2R7Cm4CMqbw";
// clean();
// async function clean() {
//   await bucket.deleteFiles({
//     prefix: `decks/${packId}`,
//   });
// }

// bucket
//     .file(`decks/${packId}/${packId}.zip`)
//     .download({destination: "text.zip"})
//     .then(()=> console.log("done"));
upload();
async function upload() {
  const deck = {} as any;
  const pack = await firestore
      .doc(`languages/${lang}/packs/${packId}`)
      .get()
      .then((d) => {
        deck.pack = d.data();
        return d;
      });

  const cards = await pack.ref.collection("cards").get().then((s) => s.docs);
  deck.cover = cards
      .find((d) => d.id == deck.pack.coverId)
      ?.data();
  deck.cards = cards
      .filter((d) => d.id != deck.pack.coverId)
      .map((d) => d.data()!);

  const translations = { } as any;
  for (const t of await pack.ref
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
      .file(`decks/${pack.id}/${pack.id}.zip`)
      .save(
          await zip.generateAsync({type: "nodebuffer"}),
          {resumable: false, gzip: "auto"});
  for (const [l, t] of Object.entries( translations)) {
    await bucket
        .file(`decks/${pack.id}/${l}.json`)
        .save(JSON.stringify(t), {resumable: false, gzip: "auto"});
  }
}
