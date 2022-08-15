import 'package:avdan/models/language.dart';
import 'package:avdan/modules/news/services/updater.dart';
import 'package:avdan/modules/settings/widgets/version_button.dart';
import 'package:avdan/modules/updates/updates.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/column_card.dart';
import 'package:avdan/shared/widgets/raxys.dart';
import 'package:flutter/material.dart';

import 'services/languages.dart';
import 'widgets/language_loading_tile.dart';
import 'widgets/language_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    this.isInitial = false,
    super.key,
  });
  final bool isInitial;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          putLocalizations(interface.localizations);
          lrnLng = languages.firstWhere((l) => !l.isInterface).name;
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: const Raxys(scale: 3),
        title: Text(localize('settings')),
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
          await clearContents();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const UpdatesScreen(),
            ),
          );
        },
        icon: const Icon(Icons.home_outlined),
        label: Text(localize('home')),
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
                  localize('honor', false),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => openLink('https://t.me/raxysstudios'),
                  icon: const Icon(Icons.send_outlined),
                  label: Text(localize('contact')),
                ),
              ],
            ),
          ),
          ColumnCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  localize('interface'),
                  textAlign: TextAlign.center,
                  style: textTheme.headline6,
                ),
              ),
              if (languages.isEmpty)
                LanguageLoadingTile(intLng)
              else
                for (final l in languages.where((l) => l.isInterface))
                  LanguageTile(
                    l,
                    mode: intLng == l.name
                        ? LanguageMode.main
                        : LanguageMode.none,
                    onTap: (alt) {
                      intLng = l.name;
                      putLocalizations(l.localizations);
                    },
                  ),
            ],
          ),
          ColumnCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  localize('learning'),
                  textAlign: TextAlign.center,
                  style: textTheme.headline6,
                ),
              ),
              if (languages.isEmpty)
                LanguageLoadingTile(lrnLng)
              else
                for (final l in languages.where((l) => !l.isInterface))
                  LanguageTile(
                    l,
                    mode: lrnLng == l.name
                        ? isAlt
                            ? LanguageMode.alt
                            : LanguageMode.main
                        : LanguageMode.none,
                    onTap: (mode) async {
                      lrnLng = l.name;
                      isAlt = mode == LanguageMode.alt;
                    },
                  ),
            ],
          ),
          const Center(child: VersionButton()),
        ],
      ),
    );
  }
}
