import 'package:avdan/l10n/app_localizations.dart';
import 'package:avdan/l10n/locale_cubit.dart';
import 'package:avdan/l10n/utils.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/language_avatar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterfaceLanguagesScreen extends StatelessWidget {
  const InterfaceLanguagesScreen({super.key});

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
                final l10n_ = snapshot.data;
                if (l10n_ == null) {
                  return const SizedBox();
                }
                final code = locale.languageCode;
                final name = codeToName(code);

                return ListTile(
                  leading: LanguageAvatar(name),
                  title: Text(translateCode(code, l10n_)),
                  subtitle: Text(translateCode(code, l10n)),
                  onTap: () async {
                    final localeCubit = context.read<LocaleCubit>();
                    if (code == localeCubit.code) {
                      Navigator.pop(context);
                      return;
                    }

                    localeCubit.update(code);
                    Prefs.interfaceLanguage = name;
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
