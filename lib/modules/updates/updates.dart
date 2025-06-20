import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/home/services/openers.dart';
import 'package:avdan/modules/updates/models/deck_preview.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/card_preview.dart';
import 'package:flutter/material.dart';

import 'services/decks.dart';
import 'services/packs.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({
    super.key,
  });

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  var decks = <DeckPreview>[];

  void init() async {
    Future<void> downloadDeck(Pack p) async {
      final deck = await fetchDeckPreview(
        Prefs.learningLanguage!.name,
        Prefs.interfaceLanguage,
        p,
      );
      setState(() {
        decks.add(deck);
      });

      await fetchDeck(p.id);
      setState(() {
        deck.isReady = true;
      });
    }

    final language = Prefs.learningLanguage;
    if (language == null) return;

    final pending = await refreshPacksList();
    await Future.wait(
      [for (final p in pending) downloadDeck(p)],
    );
    openHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Загрузка обновлений'),
        actions: [
          Builder(
            builder: (context) {
              final ready = decks.where((d) => d.isReady).length;
              final total = decks.length;
              return Text('$ready / $total');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final d in decks)
            ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: Card(
                  elevation: 0,
                  color: d.pack.color?.bg,
                  margin: EdgeInsets.zero,
                  child: CardPreview(d.cover),
                ),
              ),
              title: Text(d.cover.caption.get.titled),
              subtitle: Text(
                [
                  if (d.translation != null) d.translation.titled,
                  d.pack.length,
                ].join(' • '),
              ),
              trailing: d.isReady
                  ? Icon(Icons.check_rounded)
                  : CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
