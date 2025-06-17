import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

import 'fetcher.dart';

Future<void> checkNews(BuildContext context) async {
  final current = await getNewestUpdate(intLng);
  if (current.isAfter(pstUpd)) await openSettings(context);
}

Future<void> openSettings(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const SettingsScreen(),
    ),
  );
}
