import 'dart:convert';

import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<List<Deck>> updateDecks(
  BuildContext context,
  List<Pack> packs, {
  ValueSetter<Deck>? onLoaded,
}) async {
  final store = context.read<Store>();
  final decks = <Deck>[];

  for (final p in packs) {
    final ref = FirebaseFirestore.instance
        .doc('languages/${store.learning}/packs/${p.id}');
    final cards = await ref
        .collection('cards')
        .withConverter<avd.Card>(
          fromFirestore: (snapshot, _) => avd.Card.fromJson({
            'id': snapshot.id,
            ...snapshot.data()!,
          }),
          toFirestore: (object, _) => object.toJson(),
        )
        .get()
        .then((s) => {for (final d in s.docs) d.id: d.data()});

    final translations = <String, String>{};
    for (final c in cards.values) {
      translations[c.id!] = await ref
          .collection('translations')
          .where('cardId', isEqualTo: c.id)
          .where('language', isEqualTo: store.interface)
          .limit(1)
          .get()
          .then((s) => s.docs.first.get('text') as String);

      final image = await FirebaseStorage.instance
          .ref('static/images/${c.imagePath}')
          .getData();
      if (image != null) await store.media.put(c.imagePath, image);
      final audio = await FirebaseStorage.instance
          .ref('static/audios/${store.learning}/${c.audioPath}')
          .getData();
      if (audio != null) await store.media.put(c.audioPath, audio);
    }

    final deck = Deck(
      pack: p,
      cover: cards[p.coverId]!,
      cards: cards.values.toList(),
      translations: translations,
    );
    deck.cards.remove(deck.cover);
    decks.add(deck);
    await store.decks.put(
      deck.pack.id,
      jsonEncode(deck.toJson()),
    );
    onLoaded?.call(deck);
  }
  return decks;
}

List<Deck> restoreDecks(BuildContext context) {
  final store = context.read<Store>();
  return store.decks.values
      .map((d) => Deck.fromJson(
            jsonDecode(d) as Map<String, dynamic>,
          ))
      .whereType<Deck>()
      .toList();
}
