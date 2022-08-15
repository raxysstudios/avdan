/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import {firestore} from "./init";
import strings from "./assets/localizations.json";

upload();
async function upload() {
  for (const [k, m] of Object.entries(strings)) {
    for (const [l, t] of Object.entries(m)) {
      await firestore
          .doc(`languages/${l}`)
          .update({[`localizations.${k}`]: t});
    }
  }
}
