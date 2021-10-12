import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<Store>(
      builder: (context, store, child) {
        final learning = item.text(store.learning);
        final interface = item.text(store.interface);
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: learning,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (learning.isNotEmpty && interface.isNotEmpty)
                const TextSpan(text: '\n'),
              TextSpan(
                text: interface,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: subtitleSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
