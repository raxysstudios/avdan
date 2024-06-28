import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/player.dart';
import 'package:flutter/material.dart';

import '../widgets/card_pages.dart';

void openView(
  BuildContext context,
  Deck deck,
  int card,
) {
  final padding = EdgeInsets.only(
    top: MediaQuery.of(context).padding.top,
  );
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color.alphaBlend(
      deck.color ?? Colors.transparent,
      Theme.of(context).colorScheme.surface,
    ),
    builder: (context) {
      return Padding(
        padding: padding,
        child: CardsView(
          deck,
          initial: card,
          onChange: (i) => playCard(deck.cards[i]),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_outlined),
          ),
        ),
      );
    },
  );
}
