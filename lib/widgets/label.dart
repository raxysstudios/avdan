import 'package:avdan/data/store.dart';
import 'package:avdan/data/translations.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(this.translations, {this.scale = 1.0, this.row = false});
  final Translations translations;
  final double scale;
  final bool row;

  @override
  Widget build(BuildContext context) {
    final texts = translationPair(translations);
    var widgets = [
      Text(
        capitalize(texts[0]),
        style: TextStyle(
          fontSize: 16 * scale,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 8),
      Text(
        capitalize(texts[1]),
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: (row ? 16 : 14) * scale,
        ),
      ),
    ];

    return row
        ? Row(children: widgets)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          );
  }
}
