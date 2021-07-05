import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translations.dart';
import 'item_card.dart';
import 'package:flutter/material.dart';

class ItemsGrid extends StatelessWidget {
  final Chapter chapter;
  final bool alphabet;
  final Translations? selected;
  final ValueSetter<Translations>? onSelect;

  ItemsGrid(
    this.chapter, {
    this.alphabet = false,
    this.selected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: alphabet ? 128 : 256,
        childAspectRatio: alphabet ? 1 : 1.25,
      ),
      itemCount: chapter.items.length,
      itemBuilder: (context, index) {
        var item = chapter.items[index];
        return ItemCard(
          selected: item == selected,
          translations: item,
          image: chapter.getImageURL(item),
          onTap: () => onSelect?.call(item),
        );
      },
    );
  }
}
