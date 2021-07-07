import 'package:avdan/data/chapter.dart';
import 'item_card.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> chapters;
  final Chapter? selected;
  final ValueSetter<Chapter>? onSelect;
  const ChapterList(
    this.chapters, {
    this.selected,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selected != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Label(
              selected!.title,
              scale: 1.25,
              row: true,
            ),
          ),
        Container(
          height: 96,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final c in chapters)
                AspectRatio(
                  aspectRatio: 1,
                  child: ItemCard(
                    item: c.alphabet ? c.items.first : null,
                    image: c.alphabet ? null : c.getImageURL(c.items.first),
                    selected: selected == c,
                    onTap: () => onSelect?.call(c),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
