import 'package:flutter/material.dart';
import 'routes.dart';

void main() => runApp(MyApp());

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
