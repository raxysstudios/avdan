import 'dart:async';
import 'dart:math';

import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/screens/settings.dart';
import 'package:avdan/widgets/chapter_item.dart';
import 'package:avdan/widgets/item_view.dart';
import 'package:avdan/widgets/label.dart';
import 'package:avdan/widgets/language_title.dart';
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
      loadLanguages,
    );
  }

  bool isGrid = false;
  Chapter chapter = chapters[0];
  Map<String, String> item = chapters[0].items[0];

  var styleSelected = TextButton.styleFrom(
    backgroundColor: Colors.blue[50],
  );

  loadLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    var il = findLanguage(
      prefs.getString('interfaceLanguage'),
    );
    var ll = findLanguage(
      prefs.getString('learningLanguage'),
    );

    if (il == null || ll == null)
      openSettings();
    else
      setState(() {
        interfaceLanguage = il;
        learningLanguage = ll;
      });
  }

  openSettings() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ),
      ).then((v) => setState(() {}));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.scale(
          scale: 3,
          child: Transform.translate(
            offset: Offset(4, 0),
            child: Transform.rotate(
              angle: -pi / 4,
              child: Image.asset(
                learningLanguage.flag,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) =>
                    Container(),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: LanguageTitle(learningLanguage),
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
          Container(
            height: 96,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 1,
                child: ChapterItem(
                  translations: chapters[index].translations,
                  selected: chapter == chapters[index],
                  labeled: false,
                  onTap: () => setState(() {
                    chapter = chapters[index];
                    item = chapter.items[0];
                  }),
                ),
              ),
              itemCount: chapters.length,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
            ),
          ),
          if (isGrid)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Label(
                      chapter.translations,
                      scale: 1.25,
                      row: true,
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: [
                        for (var i in chapter.items)
                          AspectRatio(
                            aspectRatio: 1,
                            child: ChapterItem(
                              translations: i,
                              labeled: false,
                              onTap: () => setState(
                                () {
                                  item = i;
                                  isGrid = false;
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (!isGrid)
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: ItemView(
                        item,
                        action: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.grid_view),
                            onPressed: () => setState(
                              () => isGrid = true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 128,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => AspectRatio(
                        aspectRatio: 1.5,
                        child: ChapterItem(
                          translations: chapter.items[index],
                          selected: item == chapter.items[index],
                          onTap: () =>
                              setState(() => item = chapter.items[index]),
                        ),
                      ),
                      itemCount: chapter.items.length,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
