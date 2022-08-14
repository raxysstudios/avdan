import 'package:avdan/models/language.dart';
import 'package:avdan/modules/news/services/updater.dart';
import 'package:avdan/modules/updates/updates.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/column_card.dart';
import 'package:avdan/shared/widgets/raxys.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'services/languages.dart';
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
          final store = context.read<Store>();
          final interface = languages.firstWhere((l) => l.isInterface);
          store.interface = interface.name;
          putLocalizations(interface.localizations);
          store.learning = languages.firstWhere((l) => !l.isInterface).name;
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      return const Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    final store = context.watch<Store>();
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
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const UpdatesScreen(),
          ),
        ),
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
              for (final l in languages.where((l) => l.isInterface))
                LanguageTile(
                  l,
                  mode: store.interface == l.name
                      ? LanguageMode.main
                      : LanguageMode.none,
                  onTap: (alt) {
                    store.interface = l.name;
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
              for (final l in languages.where((l) => !l.isInterface))
                LanguageTile(
                  l,
                  mode: store.learning == l.name
                      ? store.alt
                          ? LanguageMode.alt
                          : LanguageMode.main
                      : LanguageMode.none,
                  onTap: (mode) async {
                    store.learning = l.name;
                    store.alt = mode == LanguageMode.alt;
                    await store.prefs.delete('lastUpdated');
                    await clearContents();
                  },
                ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () => openLink('https://github.com/raxysstudios/avdan'),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      var info = 'Loading...';
                      final package = snapshot.data;
                      if (package != null) {
                        info = [
                          'v${package.version}',
                          'b${package.buildNumber}'
                        ].join(' • ');
                      }
                      return Text(
                        info,
                        style: Theme.of(context).textTheme.caption,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
