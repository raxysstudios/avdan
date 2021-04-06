import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:avdan/data/language.dart';

class LanguageTitleBar extends StatelessWidget {
  const LanguageTitleBar(this.language, {this.selected = false});
  final Language language;
  final bool selected;

  String get translatedName =>
      language.translations[interfaceLanguage.name] ?? 'null';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 96,
          transform: Matrix4.identity()
            ..scale(1.25)
            ..translate(-64, 72)
            ..rotateZ(-0.8),
          child: Image.asset(
            language.flag,
            fit: BoxFit.fitHeight,
            errorBuilder: (
              BuildContext context,
              Object exception,
              StackTrace? stackTrace,
            ) =>
                Container(),
          ),
        ),
        Container(
          transform: Matrix4.identity()..translate(-32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalize(language.nativeName),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.blue : Colors.black,
                ),
              ),
              Text(
                capitalize(translatedName),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
