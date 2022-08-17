import 'package:avdan/models/language.dart';
import 'package:avdan/modules/languages/widgets/language_simple_tile.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/localizations.dart';
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
  var lclz = getLocalizations();
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

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: Scaffold(
        appBar: AppBar(
          // title: Text(localize('settings', map: lclz)),
          title: const Text('Languages'),
          actions: [
            IconButton(
              onPressed: () => resetContents(context),
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
            intLng = il;
            final resets = lrnLng != ll;
            lrnLng = ll;
            isAlt = al;
            await putLocalizations(lclz);
            if (resets) {
              resetContents(context);
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.home_outlined),
          label: Text(localize('home', map: lclz)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          padding: const EdgeInsets.only(bottom: 76),
          children: [
            ListTile(
              leading: const Icon(Icons.subtitles_outlined),
              title: Text(
                localize('interface', map: lclz),
                style: Theme.of(context).textTheme.headline6,
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
                    lclz = l.localizations;
                  }),
                ),
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: Text(
                localize('learning', map: lclz),
                style: Theme.of(context).textTheme.headline6,
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
                    al = ll == l.name ? !al : false;
                    ll = l.name;
                  }),
                ),
          ],
        ),
      ),
    );
  }
}
