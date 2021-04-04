import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:avdan/widgets/chapter_grid.dart';

class HomeScreen extends StatelessWidget {
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
                  text: capitalize(chapter.translations['english'] ?? ''),
                ),
            ],
          ),
          title: Text(
            capitalize(learningLanguage),
          ),
        ),
        body: TabBarView(
          children: [
            for (var chapter in chapters)
              ChapterGrid(
                chapter: chapter,
              ),
          ],
        ),
      ),
    );
  }
}
