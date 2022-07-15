import 'package:avdan/home/home_screen.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/column_card.dart';
import 'package:avdan/widgets/raxys.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'language_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.watch<Store>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(store.localize('settings')),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const HomeScreen(),
          ),
        ),
        icon: const Icon(Icons.home_rounded),
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
                      onPressed: () => launchUrlString(
                        'https://t.me/raxysstudios',
                        mode: LaunchMode.externalApplication,
                      ),
                      icon: const Icon(Icons.send_rounded),
                      label: Text(store.localize('contact')),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ColumnCard(
            header: store.localize('interface'),
            children: [
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
            header: store.localize('learning'),
            children: [
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
                onTap: () => launchUrlString(
                  'https://github.com/raxysstudios/avdan',
                  mode: LaunchMode.externalApplication,
                ),
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
