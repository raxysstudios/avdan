import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/shared/contents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<Card>> fetchCards(
  String language,
  Pack pack,
) async {
  return FirebaseFirestore.instance
      .collection('languages/$language/packs/${pack.id}/cards')
      .withConverter<Card>(
        fromFirestore: (snapshot, _) => Card.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (object, _) => object.toJson(),
      )
      .get()
      .then((s) => s.docs.map((d) => d.data()).toList());
}

Future<void> saveAssets(
  String language,
  List<Card> cards,
) async {
  for (final c in cards) {
    await putAsset(
      c.imagePath,
      await FirebaseStorage.instance
          .ref('static/images/${c.imagePath}')
          .getData(),
    );
    await putAsset(
      c.audioPath,
      await FirebaseStorage.instance
          .ref('static/audios/$language/${c.audioPath}')
          .getData(),
    );
  }
}

Future<Map<String, String>> fetchTranslations(
  String language,
  Pack pack,
  List<Card> cards,
) async {
  final collection = FirebaseFirestore.instance.collection(
    'languages/$language/packs/${pack.id}/translations',
  );
  return {
    for (final c in cards)
      c.id: await collection
          .where('cardId', isEqualTo: c.id)
          .where('language', isEqualTo: language)
          .limit(1)
          .get()
          .then((s) => s.docs.first.get('text') as String)
  };
}
