import 'package:avdan/modules/home/home.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/deck_preview.dart';
import 'checks.dart';

void update(
  BuildContext context,
  ValueSetter<DeckPreview> onPackFound,
  Future<void> Function() load,
) async {
  final store = context.read<Store>();
  final lastUpdated = await checkLanguageUpdate(
    store.learning,
    store.prefs.get(
      'lastUpdated',
      defaultValue: DateTime(0),
    ) as DateTime,
  );
  if (lastUpdated != null) {
    await checkPacksUpdate(
      store.learning,
      getAllDecks(),
      onPackFound,
    );
    store.prefs.put('lastUpdated', lastUpdated);
  }
  await load();
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
