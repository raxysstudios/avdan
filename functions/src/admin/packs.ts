/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import {default as admin, firestore} from "./init";

const lang = "east circassian";
clean();
async function clean() {
  const packs = await firestore
      .collection(`languages/${lang}/packs`)
      .listDocuments();
  for (const p of packs) {
    await firestore.recursiveDelete(p);
  }
}

upload();
async function upload() {
  // eslint-disable-next-line @typescript-eslint/no-var-requires
  const data = require(`./assets/packs/${lang}.json`);
  let i = 0;
  for (const d of data) {
    const pack = {
      "color": d.color,
      "length": d.length,
      "status": "updating",
    };
    if (pack.color == "#") delete pack.color;
    const pRef = await firestore
        .collection(`languages/${lang}/packs`)
        .add(pack);

    const coverId = await uploadCard(pRef, d.cards[0]);
    for (const c of d.cards.slice(1)) await uploadCard(pRef, c);

    pRef.update({
      coverId,
      "lastUpdated": admin.firestore.FieldValue.serverTimestamp(),
      "status": "public",
    });
    if (++i > 2) break;
  }
  await firestore
      .doc(`languages/${lang}`)
      .update({
        "lastUpdated": admin.firestore.FieldValue.serverTimestamp(),
      });
}

async function uploadCard(pRef: admin.firestore.DocumentReference, card:any) {
  const translations = card.translations;
  delete card.translations;
  const cardId = await pRef.collection("cards").add(card).then((r) => r.id);
  if (translations) {
    for (const t of translations) {
      pRef.collection("translations")
          .add({...t, cardId});
    }
  }
  return cardId;
}
