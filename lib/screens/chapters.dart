import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'chapter_items.dart';

class ChaptersScreen extends StatelessWidget {
  ChaptersScreen({required this.language});
  final String language;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: chapters.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              for (var chapter in chapters)
                Tab(
                  text: chapter.name,
                ),
            ],
          ),
          title: Text(language),
        ),
        body: TabBarView(
          children: [
            for (var chapter in chapters)
              ChapterItems(
                chapter: chapter,
              ),
          ],
        ),
      ),
    );
  }
}
