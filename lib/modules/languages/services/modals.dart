import 'package:avdan/l10n/app_localizations.dart';
import 'package:avdan/l10n/locale_cubit.dart';
import 'package:avdan/models/language.dart';
import 'package:avdan/modules/languages/widgets/locale_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<bool?> selectAltScript(
  BuildContext context,
  Language language,
) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text('Выберите письменность'),
        clipBehavior: Clip.antiAlias,
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              '1. ${language.caption.main}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              '2. ${language.caption.alt!}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
    },
  );
}

Future<Locale?> selectAppLanguage(BuildContext context) {
  return showDialog<Locale>(
    context: context,
    builder: (context) {
      var locale = context.read<LocaleCubit>().state;
      return StatefulBuilder(
        builder: (context, setState) {
          return Localizations.override(
            context: context,
            locale: locale,
            child: Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context)!;
                return AlertDialog(
                  scrollable: true,
                  title: Text(l10n.appLangTitle),
                  clipBehavior: Clip.antiAlias,
                  actions: [
                    TextButton(
                      child: Text(l10n.save),
                      onPressed: () => Navigator.of(context).pop(locale),
                    ),
                    TextButton(
                      child: Text(l10n.cancel),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  content: ListTileTheme(
                    data: const ListTileThemeData(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                    ),
                    child: Column(
                      children: [
                        for (final l in AppLocalizations.supportedLocales)
                          LocaleTile(
                            l,
                            onTap: () => setState(() {
                              locale = l;
                            }),
                          ),
                        const Divider(),
                        ListTile(
                          subtitle: Text(l10n.appLangWarning),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
