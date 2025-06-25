import 'package:avdan/l10n/app_localizations.dart';
import 'package:avdan/l10n/utils.dart';
import 'package:avdan/shared/widgets/language_avatar.dart';
import 'package:flutter/material.dart';

class LocaleTile extends StatelessWidget {
  const LocaleTile(
    this.locale, {
    this.onTap,
    super.key,
  });

  final Locale locale;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppLocalizations.delegate.load(locale),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        final code = locale.languageCode;
        final l10n = AppLocalizations.of(context)!;

        return ListTile(
          selected: l10n.localeName == locale.languageCode,
          leading: LanguageAvatar(
            codeToName(code),
          ),
          title: Text(
            translateCode(code, snapshot.data!),
          ),
          subtitle: Text(
            translateCode(code, l10n),
          ),
          onTap: onTap,
        );
      },
    );
  }
}
