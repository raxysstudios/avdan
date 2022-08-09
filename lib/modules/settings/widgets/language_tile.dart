import 'package:avdan/models/language.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LanguageMode { none, main, alt }

class LanguageTile extends StatelessWidget {
  const LanguageTile(
    this.language, {
    this.mode = LanguageMode.none,
    this.onTap,
    super.key,
  });

  final Language language;
  final LanguageMode mode;
  final ValueSetter<LanguageMode>? onTap;

  @override
  Widget build(BuildContext context) {
    var title = capitalize(language.caption.main);
    var subtitle = capitalize(language.caption.alt);
    if (mode == LanguageMode.alt) {
      final t = title;
      title = subtitle;
      subtitle = t;
    }
    final selected = mode != LanguageMode.none;
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
            if (language.caption.alt != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.swap_horiz_outlined,
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
          child: AnimatedOpacity(
            opacity: selected ? 1 : .4,
            duration: const Duration(milliseconds: 200),
            child: LanguageFlag(language.name),
          ),
        ),
        subtitle: language.isInterface
            ? null
            : Text(
                context.watch<Store>().localize(language.name),
              ),
        onTap: () => onTap?.call(
          mode != LanguageMode.main || language.caption.alt == null
              ? LanguageMode.main
              : LanguageMode.alt,
        ),
        selected: selected,
      ),
    );
  }
}
