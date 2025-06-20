import 'package:flutter/material.dart';

import '../updates.dart';

Future<void> launchUpdates(BuildContext context) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (context) => UpdatesScreen(),
    ),
  );
}
