import 'package:avdan/data/chapter.dart';
import 'package:flutter/material.dart';
import 'item_card.dart';

class ChapterTabBar extends AnimatedWidget {
  final List<Chapter> chapters;
  final TabController controller;
  final ValueSetter<int>? onTap;

  ChapterTabBar({
    Key? key,
    required this.controller,
    required this.chapters,
    this.onTap,
  }) : super(
          key: key,
          listenable: controller.animation!,
        );

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
          chapters[index.floor()].color ?? highlight,
          chapters[index.ceil()].color ?? highlight,
          index.remainder(1),
        ),
      ),
      tabs: [
        for (var i = 0; i < chapters.length; i++)
          Builder(
            builder: (context) {
              final chapter = chapters[i];
              return AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: ItemCard(
                    color: chapter.color,
                    item: chapter.alphabet ? chapter.items.first : null,
                    image: chapter.alphabet
                        ? null
                        : Image(
                            image: chapter.items.first.image(),
                          ),
                    onTap: () {
                      controller.animateTo(i);
                      onTap?.call(i);
                    },
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
