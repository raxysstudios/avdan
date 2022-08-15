/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import {createDeckPackage} from "../utils/package-deck";

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
createDeckPackage(lang, packId);
