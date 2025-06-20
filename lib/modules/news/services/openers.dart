import 'package:flutter/material.dart';

import '../news_screen.dart';

Future<void> openNews(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const NewsScreen(),
    ),
  );
}
