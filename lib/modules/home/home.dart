import 'package:avdan/modules/home/widgets/deck_view.dart';
import 'package:avdan/modules/home/widgets/home_actions.dart';
import 'package:avdan/modules/news/services/checks.dart';
import 'package:avdan/modules/updates/services/checks.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/player.dart';
import 'package:flutter/material.dart';

import 'widgets/decks_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabs;

  final decks = getAllDecks().values.toList();
  late var selectedDeck = decks.first;

  var hasUpdates = false;
  var hasNews = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      playCard(selectedDeck.cover);

      hasUpdates = await checkUpdates();
      hasNews = await checkNews();
      setState(() {});
    });

    tabs = TabController(
      length: decks.length,
      vsync: this,
    );
    tabs.animation?.addListener(() {
      final i = tabs.animation?.value.round() ?? 0;
      if (decks[i] != selectedDeck) {
        setState(() {
          selectedDeck = decks[i];
        });
        if (!tabs.indexIsChanging) playCard(selectedDeck.cover);
      }
    });
  }

  @override
  void dispose() {
    tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: AnimatedBuilder(
        animation: tabs.animation!,
        child: Stack(
          children: [
            TabBarView(
              controller: tabs,
              children: [
                for (final deck in decks) DeckView(deck),
              ],
            ),
            SafeArea(
              child: HomeActions(
                hasUpdates: hasUpdates,
                hasNews: hasNews,
                onNewsOpen: () => setState(() {
                  hasNews = false;
                }),
              ),
            )
          ],
        ),
        builder: (context, child) {
          final index = tabs.animation?.value ?? 0;
          return Material(
            color: Color.lerp(
              decks[index.floor()].pack.color?.bg,
              decks[index.ceil()].pack.color?.bg,
              index.remainder(1),
            ),
            child: child,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: 84,
        child: DecksTabBar(
          decks,
          controller: tabs,
          onTap: (i) => playCard(decks[i].cover),
        ),
      ),
    );
  }
}
