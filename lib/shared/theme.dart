import 'package:flutter/material.dart';

ThemeData buildTheme([Brightness brightness = Brightness.light]) {
  final base = switch (brightness) {
    Brightness.dark => ThemeData.dark(),
    _ => ThemeData.light(),
  };
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 223, 125, 0),
    brightness: brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
  );

  return base.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    cardTheme: const CardThemeData(
      clipBehavior: Clip.antiAlias,
    ),
    dialogTheme: const DialogThemeData(
      clipBehavior: Clip.antiAlias,
    ),
    dividerTheme: const DividerThemeData(space: 0),
  );
}
