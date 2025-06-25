import 'package:avdan/models/pack.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Pack>> refreshPacksList() async {
  final language = Prefs.learningLanguage?.name;
  if (language == null) {
    return [];
  }

  final packs = await FirebaseFirestore.instance
      .collection('languages/${Prefs.learningLanguage?.name}/packs')
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

  final decks = getAllDecks();
  for (final d in decks.values) {
    if (!packs.containsKey(d.pack.id)) {
      await clearDeck(d);
    }
  }
  return [
    for (final p in packs.values)
      if (decks[p.id]?.isOutdated(p.lastUpdated) ?? true) p
  ];
}
