import 'package:avdan/models/deck.dart';
import 'package:flutter/material.dart';

import 'card_button.dart';

class DecksView extends StatelessWidget {
  const DecksView(
    this.decks, {
    required this.controller,
    this.onTap,
    super.key,
  });
  final List<Deck> decks;
  final TabController controller;
  final ValueSetter<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      child: TabBarView(
        controller: controller,
        children: [
          for (final deck in decks)
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 128,
              ),
              itemCount: deck.cards.length,
              itemBuilder: (context, i) {
                return CardButton(
                  deck.cards[i],
                  onTap: () => onTap?.call(i),
                );
              },
            )
        ],
      ),
      builder: (context, child) {
        final index = controller.animation?.value ?? 0;
        return Material(
          color: Color.lerp(
            decks[index.floor()].color,
            decks[index.ceil()].color,
            index.remainder(1),
          ),
          child: child,
        );
      },
    );
  }
}
