import 'package:avdan/models/deck.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/updater/services/decks.dart';
import 'package:avdan/modules/updater/services/packs.dart';
import 'package:flutter/material.dart';

class UpdaterScreen extends StatefulWidget {
  const UpdaterScreen({super.key});

  @override
  State<UpdaterScreen> createState() => _UpdaterScreenState();
}

class _UpdaterScreenState extends State<UpdaterScreen> {
  var pending = <Pack>[];
  var decks = <Deck>[];

  @override
  void initState() {
    super.initState();
    fetchUpdatedPacks(context).then((p) async {
      setState(() {
        pending = p;
      });
      await updateDecks(
        context,
        p,
        onLoaded: (d) => setState(() => decks.add(d)),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => HomeScreen(decks),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            if (pending.isEmpty)
              const Text('Checking')
            else
              Text('Downloading ${decks.length + 1} / ${pending.length}'),
          ],
        ),
      ),
    );
  }
}
