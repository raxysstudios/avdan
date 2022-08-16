import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/extensions.dart';
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
              SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                toolbarHeight: 3 * kToolbarHeight,
                primary: false,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  title: FittedBox(
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
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 128,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, int i) {
                    return CardPreview(
                      deck.cards[i],
                      onTap: () => onTap?.call(i),
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
