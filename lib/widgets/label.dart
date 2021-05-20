import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(this.translations, {this.scale = 1.0, this.row = false});
  final Translations translations;
  final double scale;
  final bool row;

  String get target => translations[learningLanguage.name] ?? '';
  String get interface => translations[interfaceLanguage.name] ?? '';

  @override
  Widget build(BuildContext context) {
    var texts = [
      if (target.length > 0)
        Text(
          capitalize(target),
          style: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
      if (interface.length > 0) ...[
        SizedBox(width: 8),
        Text(
          capitalize(interface),
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: (row ? 16 : 14) * scale,
          ),
        ),
      ]
    ];

    return row
        ? Row(children: texts)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: texts,
          );
  }
}
