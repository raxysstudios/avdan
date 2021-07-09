import 'package:avdan/data/translation.dart';
import 'package:avdan/data/utils.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(
    this.item, {
    this.titleSize = 16,
    this.subtitleSize = 14,
    this.textAlign = TextAlign.start,
  });
  final Translation item;
  final double? titleSize;
  final double? subtitleSize;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final lt = capitalize(item.learning);
    final it = capitalize(item.interface);

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: subtitleSize,
        ),
        children: [
          TextSpan(
            text: lt,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2?.color,
              fontSize: titleSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (lt.isNotEmpty && it.isNotEmpty) TextSpan(text: '\n'),
          TextSpan(
            text: it,
          ),
        ],
      ),
    );
  }
}
