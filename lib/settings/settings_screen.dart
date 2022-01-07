import 'package:avdan/store.dart';
import 'package:avdan/widgets/raxys_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donate_button.dart';
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
        onPressed: () => Navigator.pop(context),
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
              const RaxysLogo(
                opacity: .1,
                scale: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      store.localize('honor', false),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DonateButton(
                            label: Text(store.localize('support')),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                launch('https://t.me/raxysstudios'),
                            icon: const Icon(Icons.send_outlined),
                            label: Text(store.localize('contact')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              store.localize('interface'),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            child: Column(
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
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              store.localize('learning'),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
