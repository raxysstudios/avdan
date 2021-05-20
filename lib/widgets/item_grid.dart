import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/item_card.dart';
import 'package:flutter/material.dart';

class ItemsGrid extends StatelessWidget {
  ItemsGrid(this.items, {this.selected, this.onSelect});
  final List<Translations> items;
  final Translations? selected;
  final ValueSetter<Translations>? onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 192,
        childAspectRatio: 1.5,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return ItemCard(
          selected: item == selected,
          translations: item,
          onTap: () => onSelect?.call(item),
        );
      },
    );
  }
}
