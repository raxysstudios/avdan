import 'package:avdan/data/chapter.dart';
import 'package:avdan/widgets/item_card.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';

class ChapterGrid extends StatelessWidget {
  ChapterGrid(this.chapter, {this.selected, this.onSelect});
  final Chapter chapter;
  final Map<String, String>? selected;
  final ValueSetter<Map<String, String>>? onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Label(
            chapter.translations,
            scale: 1.25,
            row: true,
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 256,
              childAspectRatio: 1.5,
            ),
            itemCount: chapter.items.length,
            itemBuilder: (context, index) {
              var item = chapter.items[index];
              return ItemCard(
                selected: item == selected,
                translations: item,
                onTap: () => onSelect?.call(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
