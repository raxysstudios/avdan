import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile(
    this.language, {
    this.selected = false,
    this.alt,
    this.onTap,
  });
  final Language language;
  final bool selected;
  final bool? alt;
  final Function(bool? alt)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(language.flagUrl),
      ),
      title: Text(
        capitalize(
          Store.alt && Store.learning == language
              ? language.name.learning
              : language.name.map[language.name.global]!,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: language.interface
          ? null
          : Text(
              capitalize(language.name.interface),
            ),
      trailing: alt == null
          ? null
          : Switch(
              value: alt == true,
              onChanged: (alt) => onTap?.call(alt),
            ),
      onTap: () => onTap?.call(
        alt == null || !selected ? null : !alt!,
      ),
      selected: selected,
    );
  }
}