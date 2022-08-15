import {firestore} from "firebase-admin";
import * as functions from "firebase-functions";
import "./init";
import {createDeckPackage, deleteDeckPackage} from "./utils/package-deck";
import {isUpdated} from "./utils/update-check";

export const packageDecks = functions
    .region("europe-central2")
    .firestore.document("languages/{lang}/packs/{pID}")
    .onWrite(async (change, context) => {
      const {lang, pID} = context.params;
      if (change.before.exists) {
        await deleteDeckPackage(pID);
      }
      if (change.after.exists) {
        if (isUpdated(change.after.data(), change.before.data())) {
          await createDeckPackage(lang, pID);
          await firestore().doc(`languages/${lang}`)
              .update({
                "lastUpdated": firestore.FieldValue.serverTimestamp(),
              });
        }
      }
    });
