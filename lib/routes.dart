import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/chapters.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => HomeScreen(),
  '/chapters': (context) => ChaptersScreen()
};
