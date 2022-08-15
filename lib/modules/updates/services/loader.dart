import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/home/home.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

import '../models/deck_preview.dart';
import 'checks.dart';
import 'fetches.dart';

Future<void> update(
  BuildContext context,
  ValueSetter<DeckPreview> onFound,
  ValueSetter<DeckPreview> onPack,
  ValueSetter<DeckPreview> onCard,
) async {
  final lastUpdated = await checkLanguageUpdate(lrnLng, lrnUpd);
  if (lastUpdated == null) return;

  final previews = <DeckPreview>[];
  await checkPacksUpdate(
    lrnLng,
    intLng,
    getAllDecks(),
    (d) {
      previews.add(d);
      onFound(d);
    },
  );

  for (final d in previews) {
    d.loaded = 0;
    onPack(d);

    final translations = <String, String?>{};
    final cards = await fetchCards(lrnLng, d.pack.id);
    for (final c in cards) {
      translations[c.id] = await fetchTranslation(
        lrnLng,
        intLng,
        d.pack.id,
        c.id,
      );
      await saveAssets(lrnLng, c);
      d.loaded = d.loaded! + 1;
      onCard(d);
    }

    await putDeck(Deck(
      pack: d.pack,
      cover: cards.firstWhere((c) => c.id == d.cover.id),
      cards: cards.where((c) => c.id != d.cover.id).toList(),
      translations: translations,
    ));
  }
  lrnUpd = lastUpdated;
}

void launch(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (context) => HomeScreen(
        getAllDecks().values.toList(),
      ),
    ),
  );
}
