import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/home/chapter_tabs.dart';
import 'package:avdan/home/chapters_view.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: Store.chapters.length,
      vsync: this,
    );
    _tabController.animation?.addListener(() {
      final index = _tabController.animation?.value.round() ?? 0;
      final chapter = Store.chapters[index];
      if (this.chapter != chapter)
        setState(() {
          this.chapter = chapter;
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
      backgroundColor: Color.alphaBlend(
        chapter.color ?? Colors.transparent,
        Theme.of(context).colorScheme.surface,
      ),
      builder: (_) {
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
        children: [
          Expanded(
            child: ChaptersView(
              controller: _tabController,
              chapters: Store.chapters,
              onTap: openView,
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
