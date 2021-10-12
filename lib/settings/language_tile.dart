import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:flutter/material.dart';

enum LanguageMode { none, main, alt }

class LanguageTile extends StatelessWidget {
  final Language language;
  final LanguageMode mode;
  final ValueSetter<LanguageMode>? onTap;

  const LanguageTile(
    this.language, {
    Key? key,
    this.mode = LanguageMode.none,
    this.onTap,
  }) : super(key: key);

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
            capitalize(mode == LanguageMode.alt ? titleAlt : title),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (language.alt != null) ...[
            const Spacer(),
            Icon(
              Icons.swap_horiz_outlined,
              size: 16,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(width: 4),
            Text(
              capitalize(mode == LanguageMode.alt ? title : titleAlt),
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
        language.alt != null && mode == LanguageMode.main
            ? LanguageMode.alt
            : LanguageMode.main,
      ),
      selected: mode != LanguageMode.none,
    );
  }
}
