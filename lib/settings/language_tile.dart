import 'package:avdan/capitalize.dart';
import 'package:avdan/data/language.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LanguageMode { none, main, alt }

class LanguageTile extends StatelessWidget {
  final Language language;
  final LanguageMode mode;
  final ValueSetter<LanguageMode>? onTap;

  const LanguageTile(
    this.language, {
    this.mode = LanguageMode.none,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = capitalize(language.name.get(language.id));
    String subtitle = capitalize(language.name.get(language.alt));
    if (mode == LanguageMode.alt) {
      final t = title;
      title = subtitle;
      subtitle = t;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: language.flagImage,
      ),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          if (language.alt != null) ...[
            const Spacer(),
            Icon(
              Icons.swap_horiz_rounded,
              size: 16,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(width: 4),
            Text(
              subtitle,
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
              language.name.text(context.watch<Store>().interface),
            ),
      onTap: () => onTap?.call(
        mode != LanguageMode.main || language.alt == null
            ? LanguageMode.main
            : LanguageMode.alt,
      ),
      selected: mode != LanguageMode.none,
    );
  }
}
