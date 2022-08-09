import 'package:avdan/models/deck.dart';
import 'package:flutter/material.dart';
import 'card_button.dart';

class PacksTabBar extends AnimatedWidget {
  final List<Deck> decks;
  final TabController controller;
  final ValueSetter<int>? onTap;

  PacksTabBar(
    this.decks, {
    required this.controller,
    this.onTap,
    super.key,
  }) : super(listenable: controller.animation!);

  @override
  Widget build(BuildContext context) {
    final index = controller.animation?.value ?? 0;
    final highlight = Theme.of(context).highlightColor;
    return TabBar(
      controller: controller,
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      indicatorPadding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 6,
      ),
      indicator: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: Color.lerp(
          decks[index.floor()].color ?? highlight,
          decks[index.ceil()].color ?? highlight,
          index.remainder(1),
        ),
      ),
      tabs: [
        for (var i = 0; i < decks.length; i++)
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: CardButton(
                decks[i].cover,
                onTap: () {
                  controller.animateTo(i);
                  onTap?.call(i);
                },
              ),
            ),
          ),
      ],
    );
  }
}
