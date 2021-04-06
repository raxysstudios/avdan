import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(this.translations, {this.scale = 1.0});
  final Map<String, String> translations;
  final double scale;

  String get target => translations[learningLanguage.name] ?? '';
  String get interface => translations[interfaceLanguage.name] ?? '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (target.length > 0)
          Text(
            capitalize(target),
            style: TextStyle(
              fontSize: 16 * scale,
            ),
          ),
        if (interface.length > 0)
          Text(
            capitalize(interface),
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14 * scale,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }
}
