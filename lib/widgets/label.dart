import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label({required this.translations});
  final Map<String, String> translations;

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
              color: Colors.grey[900],
              fontSize: 16,
            ),
          ),
        if (interface.length > 0)
          Text(
            capitalize(interface),
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }
}
