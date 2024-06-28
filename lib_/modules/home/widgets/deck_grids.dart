import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/player.dart';
import 'package:avdan/shared/widgets/card_preview.dart';
import 'package:avdan/shared/widgets/label.dart';
import 'package:flutter/material.dart';

class DecksGrids extends StatelessWidget {
  const DecksGrids(
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
    return TabBarView(
      controller: controller,
      children: [
        for (final deck in decks)
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 3 * kToolbarHeight,
                  child: InkWell(
                    onTap: () => playCard(deck.cover),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Label(
                            deck.cover.caption.get,
                            deck.translate(deck.cover),
                            titleSize: 40,
                            subtitleSize: 32,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 128,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: CardPreview(
                        deck.cards[i],
                        onTap: () => onTap?.call(i),
                      ),
                    );
                  },
                  childCount: deck.cards.length,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
