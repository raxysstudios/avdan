import 'package:avdan/models/language.dart';
import 'package:avdan/modules/languages/widgets/language_simple_tile.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/languages.dart';
import 'widgets/language_tile.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({
    this.isInitial = false,
    super.key,
  });
  final bool isInitial;

  @override
  State<LanguagesScreen> createState() => LanguagesScreenState();
}

class LanguagesScreenState extends State<LanguagesScreen> {
  var il = intLng;
  var ll = lrnLng;
  var al = isAlt;

  var languages = <Language>[];

  @override
  void initState() {
    super.initState();
    fetchLanguages().then(
      (ls) => setState(() {
        languages = ls;
        if (widget.isInitial) {
          il = languages.firstWhere((l) => l.isInterface).name;
          ll = languages.firstWhere((l) => !l.isInterface).name;
        }
      }),
    );
  }

  Future<void> save() async {
    intLng = il;
    lrnLng = ll;
    isAlt = al;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Languages'),
          actions: [
            if (languages.isNotEmpty)
              IconButton(
                onPressed: () async {
                  await save();
                  launchUpdates(context, true);
                },
                icon: const Icon(Icons.cloud_sync_outlined),
              ),
            const SizedBox(width: 4),
          ],
          bottom: languages.isEmpty
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(6),
                  child: LinearProgressIndicator(),
                )
              : null,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final resets = intLng != il || lrnLng != ll;
            await save();
            if (resets) {
              launchUpdates(context, true);
            } else {
              launchHome(context);
            }
          },
          icon: const Icon(Icons.home_outlined),
          label: Text('Continue'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          padding: const EdgeInsets.only(bottom: 76),
          children: [
            ListTile(
              leading: const Icon(Icons.subtitles_outlined),
              title: Text(
                'Interface',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (languages.isEmpty)
              LanguageSimpleTile(il)
            else
              for (final l in languages.where((l) => l.isInterface))
                LanguageTile(
                  l,
                  isSelected: il == l.name,
                  onTap: () => setState(() {
                    il = l.name;
                  }),
                ),
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: Text(
                'Learning',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (languages.isEmpty)
              LanguageSimpleTile(ll)
            else
              for (final l in languages.where((l) => !l.isInterface))
                LanguageTile(
                  l,
                  isSelected: ll == l.name,
                  onTap: () => setState(() {
                    if (ll != l.name) al = false;
                    ll = l.name;
                  }),
                  onAltChanged: (v) => setState(() {
                    al = v;
                  }),
                ),
          ],
        ),
      ),
    );
  }
}
