import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/home/widgets/decks_view.dart';
import 'package:avdan/modules/news/services/updater.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/shared/player.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';

import 'services/viewer.dart';
import 'widgets/packs_tab_bar.dart';

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
  late final TabController _tab;
  List<Deck> get decks => widget.decks;
  late var deck = decks.first;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await checkNews(context);
      playCard(deck.cover);
    });

    _tab = TabController(
      length: decks.length,
      vsync: this,
    );
    _tab.animation?.addListener(() {
      final i = _tab.animation?.value.round() ?? 0;
      if (decks[i] != deck) {
        setDeck(decks[i]);
      }
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void setDeck(Deck value) {
    setState(() {
      deck = value;
      playCard(deck.cover);
    });
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
        animation: _tab.animation!,
        child: SafeArea(
          child: Stack(
            children: [
              DecksView(
                decks,
                controller: _tab,
                onTap: (i) => openView(context, deck, i),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: IconButton(
                      onPressed: () {},
                      padding: const EdgeInsets.all(4),
                      icon: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: LanguageFlag(
                          lrnLng,
                          rotation: 0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: IconButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const SettingsScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        builder: (context, child) {
          final index = _tab.animation?.value ?? 0;
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
        child: SizedBox(
          height: 72,
          child: PacksTabBar(
            decks,
            controller: _tab,
            onTap: (i) {
              if (decks[i] == deck) {
                playCard(deck.cover);
              }
            },
          ),
        ),
      ),
    );
  }
}
