import 'package:avdan/models/converters/timestamp_converter.dart';
import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/shared/contents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<List<Pack>> checkPendingPacks(
  String language,
  String translationLanguage,
  Map<String, Deck> decks,
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
      .then((s) => {for (final d in s.docs) d.id: d.data()});

  for (final d in decks.values) {
    if (!packs.containsKey(d.pack.id)) await clearDeck(d);
  }
  return [
    for (final p in packs.values)
      if (decks[p.id]?.isOutdated(p.lastUpdated) ?? true) p
  ];
}
