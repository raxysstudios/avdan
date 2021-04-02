import 'package:flutter/material.dart';
import 'routes.dart';
import 'data/store.dart';

void main() async {
  await loadChapters();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avdan',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}
