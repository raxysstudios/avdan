import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/updates/services/fetches.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

import '../models/deck_preview.dart';
import '../updates.dart';
import 'checks.dart';

Future<void> updateContents(
  BuildContext context,
  ValueSetter<int> onFound,
  ValueSetter<DeckPreview> onTargeted,
  ValueSetter<VoidCallback> onProgress,
) async {
  final lastUpdated = await checkLanguageUpdate(lrnLng, lrnUpd);
  if (lastUpdated == null) return onFound(0);

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

void resetContents(BuildContext context) {
  lrnUpd = null;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const UpdatesScreen(
        resets: true,
      ),
    ),
  );
}

void launchHome(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (context) => HomeScreen(
        getAllDecks().values.toList(),
      ),
    ),
  );
}
