import 'dart:async';
import 'package:avdan/audio_player.dart';
import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:avdan/settings/settings_screen.dart';
import 'chapter_list.dart';
import 'item_grid.dart';
import 'item_view.dart';
import 'package:avdan/widgets/language_flag.dart';
import 'package:avdan/widgets/language_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  Chapter chapter = Store.chapters[0];
  Translation item = Store.chapters[0].items[0];

  final PageController _pageController = PageController();

  loadLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    final il = Store.findLanguage(
      prefs.getString('interfaceLanguage'),
    );
    final ll = Store.findLanguage(
      prefs.getString('Store.learning'),
    );

    if (il == null || ll == null)
      openSettings();
    else
      setState(() {
        Store.interface = il;
        Store.learning = ll;
      });
  }

  openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      ),
    ).then(
      (_) => setState(() {}),
    );
  }

  openPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: standardEasing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LanguageTitle(Store.learning),
        actions: [
          Stack(
            children: [
              Center(
                child: LanguageFlag(
                  Store.learning,
                  offset: Offset(-64, 0),
                ),
              )
            ],
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: openSettings,
          ),
          SizedBox(width: 4),
        ],
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                ItemsGrid(
                  chapter,
                  selected: item,
                  onSelect: (i) {
                    setState(() {
                      item = i;
                    });
                    openPage(1);
                    playItem(chapter, item);
                  },
                ),
                ItemView(
                  chapter: chapter,
                  item: item,
                  actions: IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    onPressed: () => openPage(0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.25),
                  blurRadius: 2,
                )
              ],
            ),
            child: ChapterList(
              Store.chapters,
              selected: chapter,
              onSelect: (c) {
                openPage(0);
                setState(() => chapter = c);
              },
            ),
          ),
        ],
      ),
    );
  }
}
