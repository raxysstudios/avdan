import 'dart:async';
import 'dart:math';

import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/screens/settings.dart';
import 'package:avdan/widgets/chapter_item.dart';
import 'package:avdan/widgets/item_view.dart';
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
  }
}
