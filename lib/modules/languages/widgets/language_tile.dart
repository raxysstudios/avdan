import 'package:avdan/models/language.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../languages.dart';

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
    final settings = context.watch<LanguagesScreenState>();
    final title =
        (settings.al ? language.caption.alt : null) ?? language.caption.main;
    final subtitle = language.isInterface
        ? ''
        : localize(
            language.name,
            map: settings.lclz,
          );
    return Card(
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
    );
  }
}
