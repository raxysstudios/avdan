import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:avdan/models/card.dart';
import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../providers/deck_preview.dart';

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

Future<void> fetchDeck(String pId) async {
  final archive = ZipDecoder().decodeBytes(
    await FirebaseStorage.instance
        .ref('decks/$pId/$pId.zip')
        .getData()
        .then((d) => d!),
  );
  final dynamic translations = await FirebaseStorage.instance
      .ref('decks/$pId/${Prefs.interfaceLanguage}.json')
      .getData()
      .then<dynamic>((d) => json.decode(utf8.decode(d!)));

  final deck = Deck.fromJson({
    ...json.decode(
      utf8.decode(
        archive.findFile('deck.json')?.content as List<int>,
      ),
    ),
    'translations': translations,
  });
  for (final f in archive.files) {
    if (f.isFile && !f.name.endsWith('.json')) {
      await putAsset(
        f.name,
        Uint8List.fromList(f.content as List<int>),
      );
    }
  }
  await putDeck(deck);
}
