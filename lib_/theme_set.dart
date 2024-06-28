import 'package:flutter/material.dart';

class ThemeSet {
  final ThemeData light;
  final ThemeData dark;

  ThemeSet(ColorScheme scheme)
      : light = _getLightTheme(scheme),
        dark = _getDarkTheme(scheme);

  static ThemeData _getDarkTheme(ColorScheme colorScheme) =>
      ThemeData.dark(useMaterial3: false).copyWith(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        cardTheme: const CardTheme(
          clipBehavior: Clip.antiAlias,
        ),
        dividerTheme: const DividerThemeData(space: 0),
      );

  static ThemeData _getLightTheme(ColorScheme colorScheme) =>
      ThemeData(useMaterial3: false).copyWith(
        scaffoldBackgroundColor: Colors.blueGrey.shade50,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.blue,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        cardTheme: const CardTheme(
          clipBehavior: Clip.antiAlias,
        ),
        dividerTheme: const DividerThemeData(space: 0),
      );
}
