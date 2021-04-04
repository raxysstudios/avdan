import 'package:flutter/material.dart';
import 'data/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ));
  }
}
