import 'package:avdan/data/chapter.dart';
import 'package:avdan/home/item_card.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChaptersView extends StatelessWidget {
  final List<Chapter> chapters;
  final TabController controller;
  final void Function(Chapter chapter, int item)? onTap;

  const ChaptersView({
    required this.controller,
    required this.chapters,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      child: Consumer<Store>(
        builder: (context, store, child) {
          return TabBarView(
            controller: controller,
            children: [
              for (final chapter in chapters)
                Builder(
                  builder: (context) {
                    final items = chapter.items
                        .where((i) => i.text(store.learning).isNotEmpty)
                        .toList();
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 128,
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final item = items[i];
                        return ItemCard(
                          color: chapter.color,
                          item: chapter.alphabet ? item : null,
                          image: chapter.alphabet
                              ? null
                              : Image(
                                  image: item.image(),
                                ),
                          onTap: () => onTap?.call(chapter, i),
                        );
                      },
                    );
                  },
                ),
            ],
          );
        },
      ),
      builder: (context, child) {
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
