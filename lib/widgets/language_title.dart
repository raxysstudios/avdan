import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';

class LanguageTitle extends StatelessWidget {
  final Language language;
  final TextAlign textAlign;

  const LanguageTitle(
    this.language, {
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: [
          TextSpan(
            text: capitalize(
              Store.alt && Store.learning == language
                  ? language.name.learning
                  : language.name.map[language.name.global]!,
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyText2?.color,
            ),
          ),
          if (Store.interface != language)
            TextSpan(
              text: '\n' + capitalize(language.name.interface),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).hintColor,
              ),
            ),
        ],
      ),
    );
  }
}
