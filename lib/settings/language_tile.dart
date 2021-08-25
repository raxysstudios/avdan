import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile(
    this.language, {
    this.selected = false,
    this.onTap,
  });
  final Language language;
  final bool selected;
  final Function(bool? alt)? onTap;

  bool get alt => Store.learning == language && Store.alt;
  String get title => language.name.map[language.name.id]!;
  String get titleAlt => language.name.map[language.alt]!;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(language.flagUrl),
      ),
      title: Row(
        children: [
          Text(
            capitalize(alt ? titleAlt : title),
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (language.alt != null) ...[
            Spacer(),
            Icon(
              Icons.swap_horiz_outlined,
              size: 16,
              color: Theme.of(context).hintColor,
            ),
            SizedBox(width: 4),
            Text(
              capitalize(alt ? title : titleAlt),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ],
      ),
      subtitle: language.interface
          ? null
          : Text(
              capitalize(language.name.interface),
            ),
      onTap: () => onTap?.call(
        language.alt != null && selected ? !alt : null,
      ),
      selected: selected,
    );
  }
}
