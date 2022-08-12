import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/home/widgets/decks_view.dart';
import 'package:avdan/modules/news/services/updater.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/shared/audio_player.dart';
import 'package:avdan/shared/widgets/label.dart';
import 'package:avdan/shared/widgets/language_flag.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() => checkNews(context));
    playCard(context, deck.cover);

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
      playCard(context, deck.cover);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: UnconstrainedBox(
          child: Opacity(
            opacity: .4,
            child: LanguageFlag(
              context.watch<Store>().learning,
              height: 8,
              width: 24,
              scale: 8,
            ),
          ),
        ),
        title: Label(
          deck.cover.caption.get(context.watch<Store>().alt),
          deck.translate(deck.cover),
          titleSize: 20,
          subtitleSize: 16,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            visualDensity: const VisualDensity(horizontal: 2),
          ),
        ],
      ),
      body: DecksView(
        decks,
        controller: _tab,
        onTap: (i) {
          playCard(context, deck.cards[i]);
          openView(context, deck, i);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 98,
          child: PacksTabBar(
            decks,
            controller: _tab,
            onTap: (i) {
              if (decks[i] == deck) {
                playCard(context, deck.cover);
              }
            },
          ),
        ),
      ),
    );
  }
}
