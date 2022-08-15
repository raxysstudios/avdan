import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/home/home.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/deck_preview.dart';
import 'checks.dart';

Future<void> update(
  BuildContext context,
  ValueSetter<DeckPreview> onFound,
  ValueSetter<VoidCallback> onProgress,
) async {
  final lastUpdated = await checkLanguageUpdate(lrnLng, lrnUpd);
  if (lastUpdated != null) return;

  final pending = <DeckPreview>[];
  await checkPendingPacks(
    lrnLng,
    intLng,
    getAllDecks(),
    (d) {
      pending.add(d);
      onFound(d);
    },
  );

  for (final d in pending) {
    onProgress(() {
      d.status = DeckStatus.downloading;
    });
    try {
      final archive = ZipDecoder().decodeBytes(
        await FirebaseStorage.instance
            .ref('decks/${d.pack.id}/${d.pack.id}.zip')
            .getData()
            .then((d) => d!),
      );
      final translations = await FirebaseStorage.instance
          .ref('decks/${d.pack.id}/$intLng.json')
          .getData()
          .then(
            (d) => json.decode(
              utf8.decode(d!),
            ) as Map<String, String>,
          );
      onProgress(() {
        d.status = DeckStatus.unpacking;
      });
      final deck = Deck.fromJson(
        {
          ...json.decode(
            archive.findFile('deck.json')?.content as String,
          ) as Map<String, dynamic>,
          'translations': translations,
        },
      );
      await putDeck(deck);
      for (final f in archive.files) {
        if (f.isFile && !f.name.endsWith('.json')) {
          await putAsset(
            f.name,
            Uint8List.fromList(f.content as List<int>),
          );
        }
      }
      onProgress(() {
        d.status = DeckStatus.ready;
      });
    } catch (e) {
      print('missing');
    }
  }
  print('DECK ${getAllDecks().values.first}');
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
