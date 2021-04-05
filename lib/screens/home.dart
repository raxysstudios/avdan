import 'package:avdan/data/store.dart';
import 'package:avdan/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:avdan/widgets/chapter_grid.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    capitalize(learningLanguage),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    // return  DefaultTabController(
    //   length: chapters.length,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       bottom: TabBar(
    //         tabs: [
    //           for (var chapter in chapters)
    //             Tab(
    //               text: capitalize(chapter.translations['english'] ?? ''),
    //             ),
    //         ],
    //       ),
    //       title: Text(
    //         capitalize(learningLanguage),
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         for (var chapter in chapters)
    //           ChapterGrid(
    //             chapter: chapter,
    //           ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
