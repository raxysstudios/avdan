import 'package:avdan/data/translation.dart';
import 'package:avdan/data/utils.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(
    this.item, {
    this.scale = 1.0,
    this.row = false,
  });
  final Translation item;
  final double scale;
  final bool row;

  @override
  Widget build(BuildContext context) {
    final lt = capitalize(item.learning);
    final it = capitalize(item.interface);

    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: (row ? 16 : 14) * scale,
        ),
        children: [
          TextSpan(
            text: lt,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2?.color,
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (lt.isNotEmpty && it.isNotEmpty) TextSpan(text: row ? ' ' : '\n'),
          TextSpan(
            text: it,
          ),
        ],
      ),
    );
  }
}
