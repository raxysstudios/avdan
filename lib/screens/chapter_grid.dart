import 'package:avdan/screens/chapter_item.dart';
import 'package:flutter/material.dart';
import 'package:avdan/data/chapter.dart';

class ChapterGrid extends StatelessWidget {
  ChapterGrid({required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: chapter.items.length,
      itemBuilder: (context, index) => ChapterItem(
        translations: chapter.items[index],
      ),
    );
  }
}
