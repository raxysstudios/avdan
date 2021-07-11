import 'package:flutter/material.dart';

String capitalize(String? value) {
  if (value == null) return '';
  return value
      .split(' ')
      .where((w) => w.length > 0)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

Color fixTransparent(Color color, BuildContext context) {
  return color.opacity == 0 ? Theme.of(context).highlightColor : color;
}
