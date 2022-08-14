import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/shared/contents.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

  void setup(BuildContext context) {
    late Widget screen;
    final store = context.read<Store>();
    if (store.interface.isEmpty || hasDecks) {
      screen = const SettingsScreen(isInitial: true);
    } else {
      screen = HomeScreen(getAllDecks().values.toList());
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => screen,
      ),
    );
  }

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
            Future.microtask(() => setup(context));
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
