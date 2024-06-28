import 'package:avdan/models/language.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../languages.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile(
    this.language, {
    this.isAlt = false,
    this.isSelected = false,
    required this.onTap,
    this.onAltChanged,
    super.key,
  });

  final Language language;
  final bool isAlt;
  final bool isSelected;
  final VoidCallback onTap;
  final ValueSetter<bool>? onAltChanged;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<LanguagesScreenState>();
    final title = (isSelected && settings.al ? language.caption.alt : null) ??
        language.caption.main;
    final subtitle = language.isInterface
        ? ''
        : localize(
            language.name,
            map: settings.lclz,
          );
    return Card(
      child: Column(
        children: [
          ClipRect(
            child: ListTile(
              title: Text(
                title.titled,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
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
          ),
          if (isSelected) ...[
            const Divider(),
            if (language.contact != null)
              ListTile(
                leading: const Icon(Icons.send_outlined),
                title: Text(
                  localize('contact', map: settings.lclz),
                ),
                onTap: () => openLink(language.contact!),
              ),
            if (onAltChanged != null && language.caption.alt != null)
              ListTile(
                onTap: () => onAltChanged!(!settings.al),
                leading: const Icon(Icons.swap_horiz_outlined),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        language.caption.main.titled,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Switch(
                      value: settings.al,
                      onChanged: onAltChanged,
                    ),
                    Expanded(
                      child: Text(
                        language.caption.alt.titled,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
