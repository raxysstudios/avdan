import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';

class LanguageSimpleTile extends StatelessWidget {
  const LanguageSimpleTile(
    this.language, {
    super.key,
  });
  final String language;

  @override
  Widget build(context) {
    return Card(
      child: ListTile(
        title: Text(language.titled),
        trailing: Center(
          widthFactor: .4,
          child: Opacity(
            opacity: .4,
            child: LanguageFlag(language),
          ),
        ),
      ),
    );
  }
}
