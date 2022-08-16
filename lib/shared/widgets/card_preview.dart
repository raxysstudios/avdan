import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/extensions.dart';

import 'package:flutter/material.dart';

class CardPreview extends StatelessWidget {
  const CardPreview(
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
        child: Builder(
          builder: (context) {
            final image = getAsset(card.imagePath);
            return image == null
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      (card.preview ?? card.caption).get.titled,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: 48,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Image.memory(
                    image,
                    fit: BoxFit.cover,
                  );
          },
        ),
      ),
    );
  }
}
