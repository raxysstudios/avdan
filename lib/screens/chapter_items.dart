import 'package:flutter/material.dart';
import 'package:avdan/data/chapter.dart';

class ChapterItems extends StatelessWidget {
  ChapterItems({required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) => Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: chapter.items.length,
          itemBuilder: (context, index) => TextButton(
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home),
                Text(chapter.items[index].name),
              ],
            ),
          ),
        ),
      );
}
