import 'package:avdan/home/home_screen.dart';
import 'package:avdan/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'store.dart';

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
  const App({Key? key}) : super(key: key);

  List<ThemeData> getThemes(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final floatingActionButtonTheme = FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    );
    const cardTheme = CardTheme(
      clipBehavior: Clip.antiAlias,
    );
    const dividerTheme = DividerThemeData(space: 0);
    return [
      ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.blueGrey.shade50,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        cardTheme: cardTheme,
        toggleableActiveColor: colorScheme.primary,
        floatingActionButtonTheme: floatingActionButtonTheme,
        dividerTheme: dividerTheme,
      ),
      ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        cardTheme: cardTheme,
        toggleableActiveColor: colorScheme.primary,
        floatingActionButtonTheme: floatingActionButtonTheme,
        dividerTheme: dividerTheme,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themes = getThemes(context);
    return MaterialApp(
      title: 'Avdan',
      theme: themes[0],
      darkTheme: themes[1],
      home: FutureBuilder(
        future: Future.wait([
          Future<void>.delayed(const Duration(seconds: 2)),
          context.read<Store>().load(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            SharedPreferences.getInstance().then((prefs) async {
              late Widget screen;
              if (prefs.getString('interface') == null) {
                final store = Provider.of<Store>(context, listen: false);
                store.interface = store.interface;
                store.learning = store.learning;
                store.alt = store.alt;
                screen = const SettingsScreen();
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
