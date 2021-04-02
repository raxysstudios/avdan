import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/chapters.dart';

final Map<String, WidgetBuilder> routes = {
  'home': (context) => HomeScreen(),
  'chapters': (context) => ChaptersScreen()
};
