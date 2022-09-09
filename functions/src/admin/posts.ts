/* eslint-disable max-len */
/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable require-jsdoc */
import {default as admin, firestore} from "./init";

upload();
async function upload() {
  const post = {
    created: admin.firestore.FieldValue.serverTimestamp(),
    title: "Hoşgeldiniz!",
    language: "turkish",
    body: `Herkese merhaba ve salam aleykum!

Bu mesajı okuyorsanız, **Avdæn*** uygulamasını indirmişsinizdir. Bu uygulamayı çocukların ve bazen yetişkinlerin ana dillerini öğrenebilmeleri için yaptık. Tabii ki, tam olarak konuşmanıza yardımcı olmayacak, ancak onun yardımıyla çocuklarınız en sık kullanılan yüzlerce kelimeyi onlar için basit bir biçimde öğrenebilecekler. Ayrıca uygulamanın görsel görsellerinin Kafkas halklarının geleneksel kültürüne uygun olarak seçilmesini de çok önemli buluyoruz.

Diliniz uygulamada değilse ve bunu eklemek için zaman ve çaba harcamak istiyorsanız, uygulama geliştiricileri ile iletişime geçin.

Uygulama kullanıcı için tamamen ücretsizdir. İndirin, ana dillerinizi öğrenin ve arkadaşlarınıza, komşularınıza ve akrabalarınıza uygulamayı anlatın.

_Avdæn* — beşik (Osetçe)_`,
  };
  await firestore.collection("posts").add(post);
}
