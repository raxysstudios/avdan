import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'store.dart';
import 'theme_set.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Store(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeSet(Theme.of(context).colorScheme);
    return MaterialApp(
      title: 'Avdan',
      theme: theme.light,
      darkTheme: theme.dark,
      home: FutureBuilder(
        future: Future.wait([
          Future<void>.delayed(const Duration(seconds: 2)),
          context.read<Store>().load(),
          Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            SharedPreferences.getInstance().then((prefs) async {
              late Widget screen;
              if (prefs.getString('interface') == null) {
                final store = context.read<Store>();
                store.interface = store.interface;
                store.learning = store.learning;
                store.alt = store.alt;
                screen = const SettingsScreen(isInitial: true);
              } else {
                screen = const HomeScreen();
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => screen,
                ),
              );
            });
          }
          return Material(
            child: SafeArea(
              child: Center(
                child: SizedBox(
                  height: 500,
                  child: Theme.of(context).brightness == Brightness.dark
                      ? Image.asset('assets/splash_dark.png')
                      : Image.asset('assets/splash_light.png'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
