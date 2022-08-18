/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import {bucket} from "./init";
import glob from "glob";


run();
async function run() {
  const lang = "";
  await clean("ornament");
  await upload(lang);
}

async function clean(dir="") {
  await bucket.deleteFiles({
    prefix: `static/${dir}`,
  });
}

async function upload(dir="") {
  glob(
      `assets/static/${dir}/**/*.{png,mp3}`,
      async (_, files) => {
        for (const file of files) {
          const destination = file.substring(7);
          await bucket.upload(
              file,
              {destination}
          );
          console.log(destination);
        }
      });
}
