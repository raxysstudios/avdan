import 'package:flutter/material.dart';

import '../updates.dart';

Future<void> launchUpdates(
  BuildContext context, {
  bool reset = false,
}) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (context) => UpdatesScreen(
        reset: reset,
      ),
    ),
  );
}
