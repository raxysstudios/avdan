import 'package:flutter/material.dart';
import 'package:avdan/data/language.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget(this.language);
  final Language language;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(
            language.flag,
            errorBuilder: (
              BuildContext context,
              Object exception,
              StackTrace? stackTrace,
            ) =>
                Container(),
          ),
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
              language.name,
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
