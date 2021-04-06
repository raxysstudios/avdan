import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:avdan/data/language.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget(this.language);
  final Language language;

  String get translatedName =>
      language.translations[interfaceLanguage] ?? 'null';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          language.flag,
          width: 64,
          errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace? stackTrace,
          ) =>
              Container(),
        ),
        Column(
          children: [
            Text(
              language.nativeName,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              translatedName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
