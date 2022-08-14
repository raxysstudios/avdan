import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/shared/contents.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class CardButton extends StatelessWidget {
  const CardButton(
    this.card, {
    this.onTap,
    this.color,
    super.key,
  });
  final avd.Card card;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      highlightColor: color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Builder(
            builder: (context) {
              final image = getAsset(card.imagePath);
              if (image == null) {
                final text = (card.preview ?? card.caption)
                    .get(context.read<Store>().alt);
                return Text(
                  capitalize(text),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 48,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }
              return Image.memory(image);
            },
          ),
        ),
      ),
    );
  }
}
