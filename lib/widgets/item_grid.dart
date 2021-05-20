import 'package:avdan/data/translations.dart';
import 'package:avdan/widgets/item_card.dart';
import 'package:flutter/material.dart';

class ItemsGrid extends StatelessWidget {
  ItemsGrid(this.items, {this.alphabet = false, this.selected, this.onSelect});
  final List<Translations> items;
  final bool alphabet;
  final Translations? selected;
  final ValueSetter<Translations>? onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: alphabet ? 128 : 192,
        childAspectRatio: alphabet ? 1 : 1.5,
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
