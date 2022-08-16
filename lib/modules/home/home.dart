import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/home/widgets/button_card.dart';
import 'package:avdan/modules/home/widgets/decks_view.dart';
import 'package:avdan/modules/languages/languages.dart';
import 'package:avdan/modules/settings/services/updater.dart';
import 'package:avdan/shared/player.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:flutter/material.dart';

import 'services/viewer.dart';
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
                  ButtonCard(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const LanguagesScreen(),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.language_outlined),
                        Opacity(
                          opacity: .4,
                          child: LanguageFlag(
                            lrnLng,
                            height: 16,
                            width: 48,
                            scale: 2.5,
                            offset: const Offset(24, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonCard(
                    onTap: () => openSettings(context),
                    child: const Icon(Icons.settings_outlined),
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
          child: DecksTabBar(
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
