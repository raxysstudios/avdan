import 'package:avdan/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'store.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Store.load();
  if (defaultTargetPlatform == TargetPlatform.android)
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  runApp(Avdan());
}

class Avdan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avdan',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.grey,
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.grey,
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
