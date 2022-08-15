import 'package:avdan/models/language.dart';
import 'package:avdan/modules/news/services/updater.dart';
import 'package:avdan/modules/settings/widgets/languages_column.dart';
import 'package:avdan/modules/settings/widgets/version_button.dart';
import 'package:avdan/modules/updates/updates.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/raxys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/languages.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    this.isInitial = false,
    super.key,
  });
  final bool isInitial;

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
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
          final interface = languages.firstWhere((l) => l.isInterface);
          intLng = interface.name;
          lrnLng = languages.firstWhere((l) => !l.isInterface).name;
          setState(() {
            lclz = interface.localizations;
          });
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
          leading: const Raxys(scale: 3),
          title: Text(localize('settings', map: lclz)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => openNews(context),
              icon: const Icon(Icons.feed_outlined),
            ),
            const SizedBox(width: 4),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            lrnUpd = null;
            intLng = il;
            lrnLng = ll;
            isAlt = al;
            await putLocalizations(lclz);

            await clearContents();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const UpdatesScreen(),
              ),
            );
          },
          icon: const Icon(Icons.home_outlined),
          label: Text(localize('home', map: lclz)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          padding: const EdgeInsets.only(bottom: 76),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    localize('honor', map: lclz, isTitled: false),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => openLink('https://t.me/raxysstudios'),
                    icon: const Icon(Icons.send_outlined),
                    label: Text(localize('contact', map: lclz)),
                  ),
                ],
              ),
            ),
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
                al = ll == l.name ? false : !al;
                ll = l.name;
              }),
            ),
            const Center(child: VersionButton()),
          ],
        ),
      ),
    );
  }
}
