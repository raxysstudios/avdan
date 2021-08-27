import 'package:avdan/audio_player.dart';
import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/home/chapter_tab_bar.dart';
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
          playItem(chapter);
        });
    });
    SharedPreferences.getInstance().then((prefs) async {
      if (prefs.getString('interface') == null) await openSettings();
      playItem(chapter);
    });
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> openSettings() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      ),
    );
  }

  void openView(BuildContext context, Chapter chapter, Translation item) {
    final padding = EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color.alphaBlend(
        chapter.color ?? Colors.transparent,
        Theme.of(context).colorScheme.surface,
      ),
      builder: (context) {
        return Padding(
          padding: padding,
          child: Stack(
            children: [
              ItemsView(
                chapter: chapter,
                item: item,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_outlined),
                  ),
                ),
              ),
            ],
          ),
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
                offset: Offset(8, 0),
              ),
            )
          ],
        ),
        title: Label(
          chapter.title,
          titleSize: 20,
          subtitleSize: 16,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: openSettings,
            visualDensity: VisualDensity(horizontal: 2),
          ),
        ],
      ),
      body: ChaptersView(
        controller: _tabController,
        chapters: Store.chapters,
        onTap: (chapter, item) => openView(
          context,
          chapter,
          item,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 98,
          child: ChapterTabBar(
            controller: _tabController,
            chapters: Store.chapters,
            onTap: (i) {
              final chapter = Store.chapters[i];
              if (chapter == this.chapter) playItem(chapter);
            },
          ),
        ),
      ),
    );
  }
}
