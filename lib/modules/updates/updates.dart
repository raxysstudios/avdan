import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/updates/widgets/loader_chip.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:flutter/material.dart';

import 'services/fetches.dart';
import 'services/loader.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  var packs = <Pack>[];
  var decks = <Deck>[];

  @override
  void initState() {
    super.initState();
    update(context, load);
  }

  Future<void> load(String language, List<Pack> packs) async {
    setState(() {});
    for (final p in packs) {
      final cards = await fetchCards(language, p);
      saveAssets(language, cards);
      final deck = Deck(
        pack: p,
        cover: cards.firstWhere((c) => c.id == p.coverId),
        cards: cards.where((c) => c.id != p.coverId).toList(),
        translations: await fetchTranslations(language, p, cards),
      );
      await putDeck(deck);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localize('updates')),
        actions: [
          LoaderChip(decks.length, packs.length),
        ],
      ),
      body: ListView(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          if (packs.isEmpty)
            const Text('Checking')
          else
            Text('Downloading ${decks.length} / ${packs.length}'),
        ],
      ),
    );
  }
}
