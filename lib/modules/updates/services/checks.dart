import 'package:avdan/models/card.dart';
import 'package:avdan/models/converters/timestamp_converter.dart';
import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/shared/contents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/deck_preview.dart';

Future<DateTime?> checkLanguageUpdate(
  String language,
  DateTime lastUpdated,
) async {
  final serverUpdated = await FirebaseFirestore.instance
      .doc('languages/$language')
      .get()
      .then((r) => const TimestampConverter().fromJson(r.get('lastUpdated')));
  return serverUpdated.isAfter(lastUpdated) ? serverUpdated : null;
}

Future<void> checkPendingPacks(
  String language,
  String translationLanguage,
  Map<String, Deck> decks,
  ValueSetter<DeckPreview> onPackFound,
) async {
  final packs = await FirebaseFirestore.instance
      .collection('languages/$language/packs')
      .withConverter<Pack>(
        fromFirestore: (snapshot, _) => Pack.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (object, _) => object.toJson(),
      )
      .where('status', isEqualTo: 'public')
      .get()
      .then((s) => s.docs.map((d) => d.data()));

  for (final p in packs) {
    if (decks[p.id]?.isOutdated(p.lastUpdated) ?? true) {
      onPackFound(
        await fetchDeckPreview(
          language,
          translationLanguage,
          p,
        ),
      );
    }
  }
}

Future<DeckPreview> fetchDeckPreview(
  String language,
  String translationLanguage,
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

  if (cover.imagePath != null) {
    await putAsset(
      cover.imagePath!,
      await FirebaseStorage.instance
          .ref('static/images/${cover.imagePath}')
          .getData()
          .onError((error, stackTrace) => null),
    );
  }
  return DeckPreview(
    pack: pack,
    cover: cover,
    length: pack.length,
    translation: await FirebaseFirestore.instance
        .collection('languages/$language/packs/${pack.id}/translations')
        .where('cardId', isEqualTo: cover.id)
        .where('language', isEqualTo: translationLanguage)
        .limit(1)
        .get()
        .then(
          (s) => s.size == 0 ? null : s.docs.first.get('text') as String,
        ),
  );
}
