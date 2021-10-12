import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donate_button.dart';
import 'language_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Store>(
      builder: (context, store, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(store.localize('settings')),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.home_outlined),
            label: Consumer<Store>(
              builder: (contenxt, store, child) {
                return Text(store.localize('home'));
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: ListView(
            padding: const EdgeInsets.only(bottom: 76),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Icon(Icons.landscape_outlined),
                      const SizedBox(height: 8),
                      Text(
                        store.localize('honor'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DonateButton(
                              text: store.localize('support'),
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
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        store.localize('interface'),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
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
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        store.localize('learning'),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    for (final l in store.languages.where((l) => !l.interface))
                      LanguageTile(
                        l,
                        mode: store.learning == l
                            ? store.alt
                                ? LanguageMode.main
                                : LanguageMode.alt
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
      },
    );
  }
}
