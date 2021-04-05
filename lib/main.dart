import 'package:avdan/screens/home.dart';
import 'package:avdan/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  final prefs = await SharedPreferences.getInstance();
  final firstLaunch = prefs.getBool('firstLaunch') ?? true;

  runApp(MyApp(firstLaunch: firstLaunch));
}

class MyApp extends StatelessWidget {
  MyApp({this.firstLaunch = false});
  final bool firstLaunch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avdan',
      home: this.firstLaunch ? SettingsScreen() : HomeScreen(),
    );
  }
}
