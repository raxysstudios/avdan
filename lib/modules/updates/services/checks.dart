import 'package:avdan/models/converters/timestamp_converter.dart';
import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/updates/services/fetches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/deck_preview.dart';

Future<DateTime?> checkLanguageUpdate(
  String language,
  DateTime lastUpdated,
) async {
  final globalUpdated = await FirebaseFirestore.instance
      .doc('languages/$language')
      .get()
      .then((r) => const TimestampConverter().fromJson(r.get('lastUpdated')));
  return globalUpdated.isAfter(lastUpdated) ? globalUpdated : null;
}

Future<void> checkPacksUpdate(
  String language,
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
      .get()
      .then((s) => s.docs.map((d) => d.data()));

  for (final p in packs) {
    if (decks[p.id]?.isOutdated(p.lastUpdated) ?? true) {
      onPackFound(
        await fetchDeckPreview(language, p),
      );
    }
  }
}
