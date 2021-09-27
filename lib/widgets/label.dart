import 'package:avdan/data/translation.dart';
import 'package:avdan/data/utils.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final Translation item;
  final double? titleSize;
  final double? subtitleSize;

  const Label(
    this.item, {
    Key? key,
    this.titleSize = 16,
    this.subtitleSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lt = capitalize(item.learning);
    final it = capitalize(item.interface);
    return RichText(
      textAlign: TextAlign.center,
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
          if (lt.isNotEmpty && it.isNotEmpty) const TextSpan(text: '\n'),
          TextSpan(
            text: it,
          ),
        ],
      ),
    );
  }
}
