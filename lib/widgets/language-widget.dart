import 'package:flutter/material.dart';
import 'package:avdan/data/language.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({required this.language});
  final Language language;

  String get name => language.name;
  String get native => language.translations[name] ?? '';
  String get image => 'assets/flags/$name.png';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(
            image,
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
              name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              name,
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
