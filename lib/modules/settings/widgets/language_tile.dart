import 'package:avdan/models/language.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile(
    this.language, {
    this.isAlt = false,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  final Language language;
  final bool isAlt;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var title = language.caption.main;
    var alt = language.caption.alt;
    if (isAlt && alt != null) {
      final t = title;
      title = alt;
      alt = t;
    }
    final subtitle = language.isInterface
        ? ''
        : localize(
            language.name,
            map: context.watch<SettingsScreenState>().lclz,
          );
    return ClipRect(
      child: ListTile(
        title: Row(
          children: [
            Text(
              title.titled,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (alt != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.swap_horiz_outlined,
                  size: 16,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Text(
                alt.titled,
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
            opacity: isSelected ? 1 : .4,
            duration: const Duration(milliseconds: 200),
            child: LanguageFlag(language.name),
          ),
        ),
        subtitle: subtitle.isEmpty ? null : Text(subtitle),
        onTap: onTap,
        selected: isSelected,
      ),
    );
  }
}
