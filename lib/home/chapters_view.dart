import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/home/item_card.dart';
import 'package:flutter/material.dart';

class ChaptersView extends StatelessWidget {
  final List<Chapter> chapters;
  final TabController controller;
  final void Function(Chapter chapter, Translation item)? onTap;

  ChaptersView({
    required this.controller,
    required this.chapters,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      child: TabBarView(
        controller: controller,
        children: [
          for (final chapter in chapters)
            Builder(
              builder: (_) {
                final items =
                    chapter.items.where((i) => i.learning != null).toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 128,
                  ),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final item = items[i];
                    return ItemCard(
                      color: chapter.color,
                      item: chapter.alphabet ? item : null,
                      image:
                          chapter.alphabet ? null : chapter.getImageURL(item),
                      onTap: () => onTap?.call(chapter, item),
                    );
                  },
                );
              },
            ),
        ],
      ),
      builder: (_, child) {
        final index = controller.animation?.value ?? 0;
        return Material(
          color: Color.lerp(
            chapters[index.floor()].color,
            chapters[index.ceil()].color,
            index.remainder(1),
          ),
          child: child,
        );
      },
    );
  }
}
