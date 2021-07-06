import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';

class LanguageTitle extends StatelessWidget {
  final Language language;
  const LanguageTitle(this.language);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalize(
            Store.alt && Store.learning == language
                ? language.name.learning
                : language.name.map[language.name.global]!,
          ),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (Store.interface != language)
          Text(
            capitalize(language.name.interface),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).hintColor,
            ),
          ),
      ],
    );
  }
}
