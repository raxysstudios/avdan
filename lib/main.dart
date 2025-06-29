import 'package:avdan/l10n/utils.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'l10n/locale_cubit.dart';
import 'modules/home/services/openers.dart';
import 'modules/languages/languages.dart';
import 'shared/theme.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Prefs.init();
  await initContents();

  if (Prefs.interfaceLanguage.isEmpty) {
    final locale = resolveLocale(
      WidgetsBinding.instance.platformDispatcher.locales,
    );
    Prefs.interfaceLanguage = codeToName(locale.languageCode);
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  void start(BuildContext context) {
    if (Prefs.learningLanguage == null) {
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
    return BlocProvider(
      create: (_) => LocaleCubit.fromName(Prefs.interfaceLanguage),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            title: 'Avdan',
            theme: buildTheme(),
            darkTheme: buildTheme(Brightness.dark),
            localeListResolutionCallback: (locales, supportedLocales) {
              if (locales == null) {
                return null;
              }
              final locale = resolveLocale(locales);
              Prefs.interfaceLanguage = codeToName(locale.languageCode);
              return locale;
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            home: FutureBuilder(
              future: Future.value(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    FlutterNativeSplash.remove();
                    start(context);
                  });
                }
                return Scaffold();
              },
            ),
          );
        },
      ),
    );
  }
}
