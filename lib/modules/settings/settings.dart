import 'package:avdan/modules/home/home.dart';
import 'package:avdan/modules/news/services/updater.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/column_card.dart';
import 'package:avdan/shared/widgets/raxys.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'widgets/language_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final store = context.watch<Store>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(store.localize('settings')),
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
            builder: (context) => const HomeScreen(),
          ),
        ),
        icon: const Icon(Icons.home_outlined),
        label: Text(store.localize('home')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              const Raxys(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      store.localize('honor', false),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => openLink('https://t.me/raxysstudios'),
                      icon: const Icon(Icons.send_outlined),
                      label: Text(store.localize('contact')),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ColumnCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  store.localize('interface'),
                  textAlign: TextAlign.center,
                  style: textTheme.headline6,
                ),
              ),
              for (final l in store.languages.where((l) => l.interface))
                LanguageTile(
                  l,
                  mode: store.interface == l
                      ? LanguageMode.main
                      : LanguageMode.none,
                  onTap: (alt) => store.interface = l,
                ),
            ],
          ),
          ColumnCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  store.localize('learning'),
                  textAlign: TextAlign.center,
                  style: textTheme.headline6,
                ),
              ),
              for (final l in store.languages.where((l) => !l.interface))
                LanguageTile(
                  l,
                  mode: store.learning == l
                      ? store.alt
                          ? LanguageMode.alt
                          : LanguageMode.main
                      : LanguageMode.none,
                  onTap: (mode) {
                    store.learning = l;
                    store.alt = mode == LanguageMode.alt;
                  },
                ),
            ],
          ),
          Center(
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              margin: const EdgeInsets.all(8),
              child: InkWell(
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
                        ].join(' ??? ');
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
