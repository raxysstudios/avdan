import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/updates/services/fetches.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

import '../models/deck_preview.dart';
import 'checks.dart';

Future<void> update(
  BuildContext context,
  ValueSetter<int> onFound,
  ValueSetter<DeckPreview> onTargeted,
  ValueSetter<VoidCallback> onProgress,
) async {
  final lastUpdated = await checkLanguageUpdate(lrnLng, lrnUpd);
  if (lastUpdated == null) return;

  final pending = await checkPendingPacks(
    lrnLng,
    intLng,
    getAllDecks(),
  );
  onFound(pending.length);
  await Future.wait(
    [
      for (final p in pending)
        (() async {
          final d = await fetchDeckPreview(lrnLng, intLng, p);
          d.status = DeckStatus.downloading;
          onTargeted(d);
          await fetchDeck(
            p.id,
            () => onProgress(() {
              d.status = DeckStatus.unpacking;
            }),
          );
          onProgress(() {
            d.status = DeckStatus.ready;
          });
        })(),
    ],
  );
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
