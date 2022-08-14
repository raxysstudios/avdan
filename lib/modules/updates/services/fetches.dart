import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/shared/contents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/deck_preview.dart';

Future<List<Card>> fetchCards(
  String language,
  String packId,
) async {
  return FirebaseFirestore.instance
      .collection('languages/$language/packs/$packId/cards')
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
  Card card, [
  bool audio = true,
]) async {
  await putAsset(
    card.imagePath,
    await FirebaseStorage.instance
        .ref('static/images/${card.imagePath}')
        .getData(),
  );
  if (audio) {
    await putAsset(
      card.audioPath,
      await FirebaseStorage.instance
          .ref('static/audios/$language/${card.audioPath}')
          .getData(),
    );
  }
}

Future<String?> fetchTranslation(
  String language,
  String packId,
  String cardId,
) {
  return FirebaseFirestore.instance
      .collection('languages/$language/packs/$packId/translations')
      .where('cardId', isEqualTo: cardId)
      .where('language', isEqualTo: language)
      .limit(1)
      .get()
      .then((s) => s.size == 0 ? null : s.docs.first.get('text') as String);
}

Future<DeckPreview> fetchDeckPreview(
  String language,
  Pack pack,
) async {
  final cover = await FirebaseFirestore.instance
      .doc('languages/$language/packs/${pack.id}/cards/${pack.coverId}')
      .withConverter<Card>(
        fromFirestore: (snapshot, _) => Card.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (object, _) => object.toJson(),
      )
      .get()
      .then((d) => d.data()!);
  await saveAssets(language, cover, false);
  return DeckPreview(
    pack: pack,
    cover: cover,
    length: pack.length,
    translation: await fetchTranslation(
      language,
      pack.id,
      cover.id,
    ),
  );
}
