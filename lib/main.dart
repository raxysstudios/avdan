import 'package:avdan/screens/home.dart';
import 'package:flutter/material.dart';
import 'data/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avdan',
      home: HomeScreen(),
    );
  }
}
