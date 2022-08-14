import 'package:avdan/models/deck.dart';
import 'package:avdan/modules/updates/models/deck_preview.dart';
import 'package:avdan/modules/updates/widgets/loading_chip.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/fetches.dart';
import 'services/loader.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final loading = <DeckPreview>[];

  @override
  void initState() {
    super.initState();
    update(
      context,
      (p) => setState(() => loading.add(p)),
    ).then((_) async {
      await load();
      launch(context);
    });
  }

  Future<void> load() async {
    final language = context.read<Store>().learning;
    for (final d in loading) {
      setState(() {
        d.loaded = 0;
      });
      final translations = <String, String?>{};
      final cards = await fetchCards(language, d.pack.id);
      for (final c in cards) {
        translations[c.id] = await fetchTranslation(language, d.pack.id, c.id);
        await saveAssets(language, c);
        setState(() {
          d.loaded = d.loaded! + 1;
        });
      }
      await putDeck(Deck(
        pack: d.pack,
        cover: cards.firstWhere((c) => c.id == d.cover.id),
        cards: cards.where((c) => c.id != d.cover.id).toList(),
        translations: translations,
      ));
    }
    launch(context);
  }

  @override
  Widget build(BuildContext context) {
    final alt = context.watch<Store>().alt;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localize('updates')),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(6),
          child: LinearProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (loading.every((d) => (d.loaded ?? 0) >= d.length)) {
            launch(context);
          }
        },
      ),
      body: ListView(
        children: [
          for (final d in loading)
            ListTile(
              title: Text(capitalize(d.cover.caption.get(alt))),
              subtitle: d.translation == null
                  ? null
                  : Text(capitalize(d.translation!)),
              trailing: LoadingChip(d.loaded, d.length),
            ),
        ],
      ),
    );
  }
}
