import 'package:avdan/l10n/utils.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_cubit.dart';
import 'modules/home/services/openers.dart';
import 'modules/languages/languages.dart';
import 'theme_set.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Prefs.init();
  await initContents();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  void start(BuildContext context) async {
    if (Prefs.interfaceLanguage.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const LanguagesScreen(),
        ),
      );
    } else {
      openHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeSet(Theme.of(context).colorScheme);
    return BlocProvider(
      create: (_) => LocaleCubit(AppLocalizations.supportedLocales.first),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            title: 'Avdan',
            theme: theme.light,
            darkTheme: theme.dark,
            localeResolutionCallback: (locale, supportedLocales) {
              if (!supportedLocales.contains(locale)) {
                locale = supportedLocales.first;
              }
              Prefs.interfaceLanguage = codeToName(locale!.languageCode);
              return locale;
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            home: FutureBuilder(
              future: Future<void>.delayed(
                const Duration(seconds: 2),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Future.microtask(() => start(context));
                }
                return Material(
                  child: Center(
                    child: SizedBox(
                      height: 500,
                      child: Theme.of(context).brightness == Brightness.dark
                          ? Image.asset('assets/splash_dark.png')
                          : Image.asset('assets/splash_light.png'),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
