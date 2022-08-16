import 'package:avdan/models/language.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../languages.dart';
import 'language_tile.dart';

class LanguagesColumn extends StatelessWidget {
  const LanguagesColumn(
    this.languages, {
    required this.title,
    this.selected,
    this.onTap,
    super.key,
  });
  final String title;
  final List<Language> languages;
  final String? selected;
  final ValueSetter<Language>? onTap;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<LanguagesScreenState>();
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        if (languages.isEmpty && selected != null)
          Card(
            child: ListTile(
              title: Text(selected.titled),
              trailing: Center(
                widthFactor: .4,
                child: Opacity(
                  opacity: .4,
                  child: LanguageFlag(selected),
                ),
              ),
            ),
          )
        else
          for (final l in languages)
            LanguageTile(
              l,
              isAlt: selected == l.name && settings.al,
              isSelected: selected == l.name,
              onTap: () => onTap?.call(l),
            ),
      ],
    );
  }
}
