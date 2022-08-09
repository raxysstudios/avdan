import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/audio_player.dart';
import 'package:flutter/material.dart';

import '../widgets/cards_view.dart';

void openView(
  BuildContext context,
  Deck deck,
  int card,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color.alphaBlend(
      deck.color ?? Colors.transparent,
      Theme.of(context).colorScheme.surface,
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: [
            CardsView(
              deck,
              initial: card,
              onChange: (i) => playCard(deck.cards[i]),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_outlined),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
