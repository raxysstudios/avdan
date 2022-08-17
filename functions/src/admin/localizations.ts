/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import {firestore} from "../init";
import strings from "./assets/localizations.json";

upload();
async function upload() {
  const lclz = {} as any;
  for (const [k, m] of Object.entries(strings)) {
    for (const [l, t] of Object.entries(m)) {
      if (!lclz[l]) lclz[l] = {};
      lclz[l][k] = t;
    }
  }
  for (const [l, localizations] of Object.entries(lclz)) {
    await firestore
        .doc(`languages/${l}`)
        .update({localizations});
  }
}
