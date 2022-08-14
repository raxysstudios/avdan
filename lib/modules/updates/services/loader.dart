import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/home/home.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checks.dart';

void update(
  BuildContext context,
  Future<void> Function(String langauge, List<Pack> packs) load,
) async {
  final store = context.read<Store>();
  final language = context.read<Store>().learning;
  final lastUpdated = await checkLanguageUpdate(
    language,
    store.prefs.get(
      'lastUpdated',
      defaultValue: DateTime(0),
    ) as DateTime,
  );
  if (lastUpdated != null) {
    await load(
      language,
      await checkPacksUpdate(
        language,
        getAllDecks(),
      ),
    );
    store.prefs.put('lastUpdated', lastUpdated);
  }
  launch(context);
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
