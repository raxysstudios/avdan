import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/language_flag.dart';
import 'package:avdan/widgets/language_title.dart';
import 'package:avdan/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(
    this.language, {
    this.selected = false,
    this.alt = false,
    this.onTap,
  });
  final Language language;
  final bool selected;
  final bool alt;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: SelectableCard(
        onTap: onTap,
        selected: selected,
        elevated: true,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: LanguageFlag(
              language,
              offset: Offset(-24, 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LanguageTitle(language),
          ),
        ],
      ),
    );
  }
}
