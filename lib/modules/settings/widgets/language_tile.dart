import 'package:avdan/models/language.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
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
    return ClipRect(
      child: ListTile(
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (language.alt != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  size: 16,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ],
        ),
        trailing: Center(
          widthFactor: .4,
          child: LanguageFlag(language.id),
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
      ),
    );
  }
}
