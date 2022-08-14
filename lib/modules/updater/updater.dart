import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/updater/services/decks.dart';
import 'package:avdan/modules/updater/services/packs.dart';
import 'package:avdan/shared/contents_store.dart' as contents;
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdaterScreen extends StatefulWidget {
  const UpdaterScreen({super.key});

  @override
  State<UpdaterScreen> createState() => _UpdaterScreenState();
}

class _UpdaterScreenState extends State<UpdaterScreen> {
  var packs = <Pack>[];
  var decks = <Deck>[];

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() async {
    final languageUpdate = await checkLanguageUpdate(context);
    if (languageUpdate == null) {
      decks = contents.getAllDecks().values.toList();
    } else {
      packs = await fetchUpdatedPacks(
        context,
        contents.getAllDecks(),
      );
      setState(() {});
      await updateDecks(
        context,
        packs,
        onLoaded: (d) => setState(() => decks.add(d)),
      );
      context.read<Store>().prefs.put('lastUpdated', languageUpdate);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => HomeScreen(decks),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
