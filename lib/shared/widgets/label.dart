import 'package:avdan/shared/extensions.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label(
    this.title,
    this.subtitle, {
    this.titleSize = 16,
    this.subtitleSize = 14,
    super.key,
  });
  final String title;
  final String subtitle;
  final double? titleSize;
  final double? subtitleSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: title.titled,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontSize: titleSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (title.isNotEmpty && subtitle.isNotEmpty)
            const TextSpan(text: '\n'),
          TextSpan(
            text: subtitle.titled,
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: subtitleSize,
            ),
          ),
        ],
      ),
    );
  }
}
