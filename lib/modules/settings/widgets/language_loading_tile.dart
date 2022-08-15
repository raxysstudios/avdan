import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';

class LanguageLoadingTile extends StatelessWidget {
  const LanguageLoadingTile(
    this.language, {
    super.key,
  });
  final String language;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ListTile(
        leading: const CircularProgressIndicator(),
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
