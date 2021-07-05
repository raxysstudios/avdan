import 'package:avdan/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Store.load();
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
