/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import "./admin";
import * as admin from "firebase-admin";
import glob from "glob";

foo();
async function foo() {
  const storage = admin.storage().bucket();
  await storage.deleteFiles({prefix: "static/"});
  glob( "static/**/*.png", async ( _, files ) => {
    for (const file of files) {
      await storage.upload(
          file,
          {destination: file}
      );
      console.log(file);
    }
  });
}
