import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:flutter/material.dart';

class LanguageTitle extends StatelessWidget {
  const LanguageTitle(this.language);
  final Language language;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalize(language.name.native),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (language.name.interface != language.name.native)
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
