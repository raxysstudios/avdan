import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label({required this.translations});
  final Map<String, String> translations;

  String get target => translations[learningLanguage] ?? '';
  String get interface => translations[interfaceLanguage] ?? '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          capitalize(target),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          capitalize(interface),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
