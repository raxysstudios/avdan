import 'package:flutter/material.dart';
import 'package:avdan/data/chapter.dart';

class ChapterItems extends StatelessWidget {
  ChapterItems({required this.chapter});
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
      itemBuilder: (context, index) {
        var filename = 'assets/images/${chapter.items[index].name}.png';
        return TextButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(filename),
                ),
                Text(chapter.items[index].name),
              ],
            ),
          ),
        );
      },
    );
  }
}
