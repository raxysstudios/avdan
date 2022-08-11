import 'package:avdan/models/language.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Future<DateTime?> _checkLanguageUpdate(BuildContext context) async {
  final store = context.read<Store>();
  final serverUpdated = await FirebaseFirestore.instance
      .doc('languages/${store.learning}')
      .withConverter<Language>(
        fromFirestore: (snapshot, _) => Language.fromJson(snapshot.data()!),
        toFirestore: (object, _) => object.toJson(),
      )
      .get()
      .then((r) => r.data()?.lastUpdated);
  if (serverUpdated != null) {
    final localUpdated = store.prefs.get(
      'lastUpdated',
      defaultValue: DateTime(0),
    ) as DateTime;
    if (serverUpdated.isAfter(localUpdated)) return serverUpdated;
  }
  return null;
}

Future<List<Pack>> fetchUpdatedPacks(BuildContext context) async {
  final store = context.read<Store>();
  final languageUpdate = await _checkLanguageUpdate(context);
  if (languageUpdate == null) return [];

  final packs = await FirebaseFirestore.instance
      .collection('languages/${store.learning}/packs')
      .withConverter<Pack>(
        fromFirestore: (snapshot, _) => Pack.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        }),
        toFirestore: (object, _) => object.toJson(),
      )
      .get()
      .then((s) => s.docs.map((d) => d.data()));

  final pending = <Pack>[];
  for (final p in packs) {
    final deck = store.decks.get(p.id);
    if (deck != null) {
      final pack = Pack.fromJson(deck['pack'] as Map<String, dynamic>);
      if (pack.lastUpdated.millisecondsSinceEpoch >
          p.lastUpdated.millisecondsSinceEpoch) {
        pending.add(pack);
      }
    }
  }

  store.prefs.put('lastUpdated', languageUpdate);
  return pending;
}
