import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/shared/contents.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Builder(
              builder: (context) {
                final store = context.read<Store>();
                final image = getAsset(card.imagePath);
                if (image == null) {
                  return Text(
                    (card.preview ?? card.caption).get(store.alt),
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return Image.memory(image);
              },
            ),
          ),
        ),
      ),
    );
  }
}
