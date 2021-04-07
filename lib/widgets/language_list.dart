import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/language_card.dart';
import 'package:flutter/material.dart';

class LanguageList extends StatelessWidget {
  LanguageList(
    this.languages, {
    this.selected,
    this.onSelect,
  });
  final List<Language> languages;
  final ValueSetter<Language>? onSelect;
  final Language? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        itemBuilder: (context, index) {
          var lang = languages[index];
          return LanguageCard(
            lang,
            selected: selected == lang,
            onTap: () => onSelect?.call(lang),
          );
        },
      ),
    );
  }
}
