import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/deck.dart';
import 'store.dart';
import 'theme_set.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
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
            late Widget screen;
            final store = context.read<Store>();
            if (!store.prefs.containsKey('interface') || store.decks.isEmpty) {
              screen = const SettingsScreen(isInitial: true);
            } else {
              screen = HomeScreen(
                store.decks.values.map(Deck.fromJson).toList(),
              );
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => screen,
              ),
            );
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
