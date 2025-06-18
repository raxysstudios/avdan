import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/home/widgets/deck_view.dart';
import 'package:avdan/modules/home/widgets/home_actions.dart';
import 'package:avdan/modules/news/services/fetcher.dart';
import 'package:avdan/shared/player.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

import '../updates/services/checks.dart';
import 'widgets/decks_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
    this.decks, {
    super.key,
  });
  final List<Deck> decks;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabs;
  List<Deck> get decks => widget.decks;
  late var deck = decks.first;
  var hasUpdates = false;
  var hasNews = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      playCard(deck.cover);
    });
    checkNews(intLng).then(
      (hasNews) => setState(() {
        this.hasNews = hasNews;
      }),
    );
    Future.wait([
      checkLanguageUpdate(intLng, intUpd),
      checkLanguageUpdate(lrnLng, lrnUpd),
    ]).then(
      (ts) => setState(() {
        hasUpdates = ts.any((t) => t != null);
      }),
    );

    tabs = TabController(
      length: decks.length,
      vsync: this,
    );
    tabs.animation?.addListener(() {
      final i = tabs.animation?.value.round() ?? 0;
      if (decks[i] != deck) {
        setState(() {
          deck = decks[i];
        });
        if (!tabs.indexIsChanging) playCard(deck.cover);
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
        child: SafeArea(
          child: Stack(
            children: [
              TabBarView(
                controller: tabs,
                children: [
                  for (final deck in decks) DeckView(deck),
                ],
              ),
              HomeActions(
                hasUpdates: hasUpdates,
                hasNews: hasNews,
              ),
            ],
          ),
        ),
        builder: (context, child) {
          final index = tabs.animation?.value ?? 0;
          return Material(
            color: Color.lerp(
              decks[index.floor()].color,
              decks[index.ceil()].color,
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
