import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(this.translations, {this.large = false});
  final Map<String, String> translations;
  final bool large;

  String get target => translations[learningLanguage.name] ?? '';
  String get interface => translations[interfaceLanguage.name] ?? '';

  var shadow = <Shadow>[
    Shadow(
      blurRadius: 16.0,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (target.length > 0)
          Text(
            capitalize(target),
            style: TextStyle(
              fontSize: large ? 32 : 16,
              shadows: shadow,
            ),
          ),
        if (interface.length > 0)
          Text(
            capitalize(interface),
            style: TextStyle(
              color: Colors.black54,
              fontSize: large ? 26 : 14,
              fontStyle: FontStyle.italic,
              shadows: shadow,
            ),
          ),
      ],
    );
  }
}
