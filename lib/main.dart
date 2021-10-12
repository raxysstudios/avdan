import 'package:avdan/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:provider/provider.dart';

import 'store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ChangeNotifierProvider(
    create: (context) => Store(),
    child: const App(),
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
      ),
      ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        cardTheme: cardTheme,
        toggleableActiveColor: colorScheme.primary,
        floatingActionButtonTheme: floatingActionButtonTheme,
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
      home: Consumer<Store>(
        builder: (context, store, child) {
          return FutureBuilder(
            future: Future.wait([
              Future.delayed(const Duration(seconds: 1)),
              store.load(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(store),
                  ),
                );
              }
              return child ?? const SizedBox();
            },
          );
        },
        child: Material(
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
        ),
      ),
    );
  }
}
