import 'package:flutter/material.dart';

import 'label.dart';

class LanguageCard extends StatelessWidget {
  LanguageCard({required this.translations});
  final Map<String, String> translations;

  String get name => translations['english'] ?? '';
  String get image => 'assets/flags/$name.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(image)),
          Label(translations: translations),
        ],
      ),
    );
  }
}
