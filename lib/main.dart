import 'package:avdan/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'store.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Store.load();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avdan',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
