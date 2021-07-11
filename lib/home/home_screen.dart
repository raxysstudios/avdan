import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/home/chapter_tabs.dart';
import 'package:avdan/home/item_card.dart';
import 'package:avdan/home/items_view.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  var chapter = Store.chapters.first;
  var color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    // color = fixTransparent(color);
    _tabController = TabController(
      length: Store.chapters.length,
      vsync: this,
    );
    _tabController.animation?.addListener(() {
      final animation = _tabController.animation?.value ?? 0;
      final colorA = Store.chapters[animation.floor()].color;
      final colorB = Store.chapters[animation.ceil()].color;
      setState(() {
        color = Color.lerp(
          colorA,
          colorB,
          animation.remainder(1),
        )!;
        final chapter = Store.chapters[animation.round()];
        if (this.chapter != chapter) this.chapter = chapter;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('interface') == null) openSettings();
    });
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color fixTransparent(Color color) {
    return color.opacity == 0 ? Theme.of(context).highlightColor : color;
  }

  void openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      ),
    );
  }

  void openView(Chapter chapter, Translation item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ItemsView(
          chapter: chapter,
          item: item,
        );
      },
    );
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
      backgroundColor: Color.alphaBlend(
        color,
        Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (final chapter in Store.chapters)
                  Builder(
                    builder: (_) {
                      final items = chapter.items
                          .where((i) => i.learning != null)
                          .toList();
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 128,
                        ),
                        itemCount: items.length,
                        itemBuilder: (_, i) {
                          final item = items[i];
                          return ItemCard(
                            item: chapter.alphabet ? item : null,
                            image: chapter.alphabet
                                ? null
                                : chapter.getImageURL(item),
                            onTap: () => openView(chapter, item),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
          ChapterTabs(
            controller: _tabController,
            chapters: Store.chapters,
          ),
        ],
      ),
    );
  }
}
