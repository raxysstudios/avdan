import 'package:avdan/data/chapter.dart';
import 'package:avdan/screens/item_card.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatelessWidget {
  const ChapterList(this.chapters, {this.selected, this.onSelect});
  final List<Chapter> chapters;
  final Chapter? selected;
  final ValueSetter<Chapter>? onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selected != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Label(
              (selected as Chapter).translations,
              scale: 1.25,
              row: true,
            ),
          ),
        Container(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final chap = chapters[index];
              return AspectRatio(
                aspectRatio: 1,
                child: ItemCard(
                  translations: index == 0 ? chap.items[0] : chap.translations,
                  selected: selected == chap,
                  labeled: false,
                  onTap: () => onSelect?.call(chap),
                ),
              );
            },
            itemCount: chapters.length,
          ),
        ),
      ],
    );
  }
}
