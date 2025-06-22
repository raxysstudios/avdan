import 'package:avdan/l10n/app_localizations.dart';
import 'package:avdan/l10n/locale_cubit.dart';
import 'package:avdan/l10n/utils.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/language_avatar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterfaceLanguages extends StatelessWidget {
  const InterfaceLanguages({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.interface),
      ),
      body: ListView(
        children: [
          for (final locale in AppLocalizations.supportedLocales)
            FutureBuilder(
              future: AppLocalizations.delegate.load(locale),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                final l10n_ = snapshot.data!;
                final code = locale.languageCode;

                return ListTile(
                  leading: LanguageAvatar(codeToName(code)),
                  title: Text(translateCode(code, l10n_)),
                  subtitle: Text(translateCode(code, l10n)),
                  onTap: () async {
                    context.read<LocaleCubit>().update(code);
                    FirebaseAnalytics.instance.setUserProperty(
                      name: 'interface_language',
                      value: Prefs.interfaceLanguage,
                    );
                    launchUpdates(context);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
