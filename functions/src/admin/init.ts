import * as admin from "firebase-admin";
import serviceAccount from "./serviceAccountKey.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as never),
  storageBucket: "avdan-918fc.appspot.com",
});
