import 'package:avdan/audio_player.dart';
import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/home/item_card.dart';
import 'package:avdan/home/item_view.dart';
import 'package:avdan/store.dart';
import 'package:avdan/settings/settings_screen.dart';
import 'package:avdan/widgets/label.dart';
import 'package:avdan/widgets/language_flag.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Chapter chapter = Store.chapters[0];
  List<Translation> get items =>
      chapter.items.where((i) => i.learning != null).toList();
  late Translation item;

  final PageController _pageController = PageController();

  void openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      ),
    ).then(
      (_) => setState(() {
        item = items.first;
      }),
    );
  }

  void openPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: standardEasing,
    );
  }

  @override
  void initState() {
    super.initState();
    item = items.first;
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('interface') == null) openSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Stack(
          children: [
            Center(
              child: LanguageFlag(
                Store.learning,
                offset: Offset(16, 0),
              ),
            )
          ],
        ),
        title: Center(
          child: Label(
            chapter.title,
            titleSize: 20,
            subtitleSize: 16,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: openSettings,
            visualDensity: VisualDensity(horizontal: 2),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 128,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ItemCard(
                      item: chapter.alphabet ? item : null,
                      image:
                          chapter.alphabet ? null : chapter.getImageURL(item),
                      onTap: () {
                        setState(() {
                          this.item = item;
                        });
                        openPage(1);
                        playItem(chapter, item);
                      },
                    );
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
            height: 96,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final c in Store.chapters)
                  AspectRatio(
                    aspectRatio: 1,
                    child: ItemCard(
                      item: c.alphabet ? c.items.first : null,
                      image: c.alphabet ? null : c.getImageURL(c.items.first),
                      selected: chapter == c,
                      onTap: () {
                        setState(() {
                          chapter = c;
                          item = items.first;
                        });
                        openPage(0);
                      },
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
