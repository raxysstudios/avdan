import 'package:avdan/models/language.dart';
import 'package:avdan/modules/updates/updates.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/languages.dart';
import 'widgets/languages_column.dart';

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
          intLng = languages.firstWhere((l) => l.isInterface).name;
          il = intLng;
          lrnLng = languages.firstWhere((l) => !l.isInterface).name;
          ll = lrnLng;
        }
      }),
    );
  }

  void start(bool resets) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => UpdatesScreen(
          resets: resets,
        ),
      ),
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
              onPressed: () => start(true),
              icon: const Icon(Icons.cloud_sync_outlined),
            ),
            const SizedBox(width: 4),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            lrnUpd = null;
            intLng = il;
            final resets = lrnLng != ll;
            lrnLng = ll;
            isAlt = al;
            await putLocalizations(lclz);
            start(resets);
          },
          icon: const Icon(Icons.home_outlined),
          label: Text(localize('home', map: lclz)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          padding: const EdgeInsets.only(bottom: 76),
          children: [
            LanguagesColumn(
              languages.where((l) => l.isInterface).toList(),
              title: localize('interface', map: lclz),
              selected: il,
              onTap: (l) => setState(() {
                il = l.name;
                lclz = l.localizations;
              }),
            ),
            LanguagesColumn(
              languages.where((l) => !l.isInterface).toList(),
              title: localize('learning', map: lclz),
              selected: ll,
              onTap: (l) => setState(() {
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
