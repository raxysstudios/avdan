import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/card_preview.dart';

class DecksTabBar extends AnimatedWidget {
  final List<Deck> decks;
  final TabController controller;
  final ValueSetter<int>? onTap;

  DecksTabBar(
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
      padding: const EdgeInsets.symmetric(horizontal: 2),
      indicatorPadding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 4,
      ),
      dividerHeight: 0,
      indicator: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: Color.lerp(
          decks[index.floor()].pack.color?.bg ?? highlight,
          decks[index.ceil()].pack.color?.bg ?? highlight,
          index.remainder(1),
        ),
      ),
      tabAlignment: TabAlignment.start,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      tabs: [
        for (var i = 0; i < decks.length; i++)
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 4, 2, 2),
              child: CardPreview(
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
