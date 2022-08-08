/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import "./init";
import * as admin from "firebase-admin";
import glob from "glob";

const storage = admin.storage().bucket();

clean();
async function clean(dir="") {
  await storage.deleteFiles({
    prefix: `static/${dir}`,
  });
}

upload();
async function upload(dir="") {
  glob(
      `static/${dir}/**/*.{png,mp3}`,
      async (_, files) => {
        for (const file of files) {
          await storage.upload(
              file,
              {destination: file}
          );
          console.log(file);
        }
      });
}
