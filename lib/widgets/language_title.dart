import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class LanguageTitle extends StatelessWidget {
  const LanguageTitle(this.language);
  final Language language;
  String get translatedName =>
      language.translations[interfaceLanguage.name] ?? 'null';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalize(language.nativeName),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          capitalize(translatedName),
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
