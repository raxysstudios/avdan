import 'package:avdan/models/converters/timestamp_converter.dart';
import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Future<DateTime?> checkLanguageUpdate(BuildContext context) async {
  final store = context.read<Store>();
  final globalUpdated = await FirebaseFirestore.instance
      .doc('languages/${store.learning}')
      .get()
      .then((r) => const TimestampConverter().fromJson(
            r.get('lastUpdated'),
          ));

  final localUpdated = store.prefs.get(
    'lastUpdated',
    defaultValue: DateTime(0),
  ) as DateTime;
  if (globalUpdated.isAfter(localUpdated)) return globalUpdated;
  return null;
}

Future<List<Pack>> fetchUpdatedPacks(
  BuildContext context,
  Map<String, Deck> decks,
) async {
  final packs = await FirebaseFirestore.instance
      .collection('languages/${context.read<Store>().learning}/packs')
      .withConverter<Pack>(
        fromFirestore: (snapshot, _) => Pack.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (object, _) => object.toJson(),
      )
      .get()
      .then((s) => s.docs.map((d) => d.data()));

  return [
    for (final p in packs)
      if (decks[p.id]?.isOutdated(p.lastUpdated) ?? true) p
  ];
}
