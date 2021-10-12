import 'package:avdan/data/language.dart';
import 'package:avdan/store.dart';
import 'package:avdan/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  String get title => language.name.get(language.id)!;
  String get titleAlt => language.name.get(language.alt)!;

  @override
  Widget build(BuildContext context) {
    String? title = language.name.get(language.id);
    String? subtitle = language.name.get(language.alt);
    if (mode == LanguageMode.alt) {
      final t = title;
      title = subtitle;
      subtitle = t;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(language.flagUrl),
      ),
      title: Row(
        children: [
          Text(
            capitalize(title),
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
              capitalize(subtitle),
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
          : Consumer<Store>(
              builder: (contenxt, store, child) {
                return Text(
                  capitalize(
                    getText(language.name, store.interface),
                  ),
                );
              },
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
