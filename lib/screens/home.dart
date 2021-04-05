import 'dart:async';

import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/screens/settings.dart';
import 'package:avdan/widgets/chapter_item.dart';
import 'package:avdan/widgets/item_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState() {
    Timer(
      Duration(),
      () async {
        final prefs = await SharedPreferences.getInstance();
        final language = prefs.getString('learningLanguage');
        if (language == null) openSettings();
      },
    );
  }

  Chapter chapter = chapters[0];
  Map<String, String> item = chapters[0].items[0];

  var styleSelected = TextButton.styleFrom(
    backgroundColor: Colors.blue[50],
  );

  openSettings() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          capitalize(learningLanguage),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: openSettings,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: ItemView(translations: item),
            ),
          ),
          Container(
            height: 128,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 1.2,
                child: TextButton(
                  onPressed: () => setState(() => item = chapter.items[index]),
                  child: ChapterItem(
                    translations: chapter.items[index],
                  ),
                  style: item == chapter.items[index]
                      ? styleSelected
                      : TextButton.styleFrom(),
                ),
              ),
              itemCount: chapter.items.length,
            ),
          ),
          Container(
            height: 128,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 1.2,
                child: TextButton(
                  onPressed: () => setState(() {
                    chapter = chapters[index];
                    item = chapter.items[0];
                  }),
                  child: ChapterItem(
                    translations: chapters[index].translations,
                  ),
                  style: chapter == chapters[index]
                      ? styleSelected
                      : TextButton.styleFrom(),
                ),
              ),
              itemCount: chapters.length,
            ),
          ),
        ],
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
