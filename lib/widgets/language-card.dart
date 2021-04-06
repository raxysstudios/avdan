import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/widgets/language-widget.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(this.language, {this.onTap});
  final Language language;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 192,
          child: ClipRect(
            child: LanguageWidget(
              language,
            ),
          ),
        ),
      ),
    );
  }
}
