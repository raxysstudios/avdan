import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:avdan/data/language.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget(this.language);
  final Language language;

  String get translatedName =>
      language.translations[interfaceLanguage.name] ?? 'null';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          transform: Matrix4.identity()
            ..translate(-80, 64)
            ..scale(4)
            ..rotateZ(-0.8),
          child: Image.asset(
            language.flag,
            height: 32,
            errorBuilder: (
              BuildContext context,
              Object exception,
              StackTrace? stackTrace,
            ) =>
                Container(),
          ),
        ),
        SizedBox(width: 16),
        Column(
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
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
