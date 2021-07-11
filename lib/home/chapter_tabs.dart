import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/utils.dart';
import 'package:flutter/material.dart';
import 'item_card.dart';

class ChapterTabs extends AnimatedWidget {
  final List<Chapter> chapters;
  final TabController controller;

  ChapterTabs({
    required this.controller,
    required this.chapters,
  }) : super(listenable: controller.animation!);

  Color getColor(BuildContext context) {
    final index = controller.animation?.value ?? 0;
    final colorA = fixTransparent(
      chapters[index.floor()].color,
      context,
    );
    final colorB = fixTransparent(
      chapters[index.ceil()].color,
      context,
    );
    return Color.lerp(
      colorA,
      colorB,
      index.remainder(1),
    )!;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.25),
            blurRadius: 2,
          )
        ],
      ),
      height: 98,
      child: TabBar(
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
          color: color,
        ),
        tabs: [
          for (var i = 0; i < chapters.length; i++)
            Builder(
              builder: (_) {
                final chapter = chapters[i];
                return AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: ItemCard(
                      color: fixTransparent(
                        chapter.color,
                        context,
                      ),
                      item: chapter.alphabet ? chapter.items.first : null,
                      image: chapter.alphabet
                          ? null
                          : chapter.getImageURL(chapter.items.first),
                      onTap: () => controller.animateTo(i),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
