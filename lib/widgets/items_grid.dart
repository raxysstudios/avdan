import 'package:avdan/data/chapter.dart';
import 'package:avdan/widgets/item_card.dart';
import 'package:flutter/material.dart';

class ItemsGrid extends StatelessWidget {
  ItemsGrid(this.chapter, {this.selected, this.onSelect});
  final Chapter chapter;
  final Map<String, String>? selected;
  final ValueSetter<Map<String, String>>? onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
