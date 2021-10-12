import 'dart:async';
import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/widgets/donate_button.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'language_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final List<Language> interface;
  late final List<Language> learning;
  SharedPreferences? prefs;

  @override
  initState() {
    super.initState();
    interface = Store.languages.where((l) => l.interface).toList();
    learning = Store.languages.where((l) => !l.interface).toList();
    saveChoice('interface', Store.interface);
    saveChoice('learning', Store.learning, alt: Store.alt);
  }

  Future<void> saveChoice(
    String index,
    Language language, {
    bool? alt,
  }) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setString(index, language.name.id!);
    if (alt != null) await prefs!.setBool('alt', alt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          capitalize(Localization.get('settings')),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.home_outlined),
        label: Text(
          capitalize(Localization.get('home')),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    Localization.get('honor'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DonateButton(
                          text: capitalize(Localization.get('support')),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => launch('https://t.me/raxysstudios'),
                          icon: const Icon(Icons.send_outlined),
                          label: Text(capitalize(Localization.get('contact'))),
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
                    capitalize(Localization.get('interface')),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                for (final l in interface)
                  LanguageTile(
                    l,
                    mode: Store.interface == l
                        ? LanguageMode.main
                        : LanguageMode.none,
                    onTap: (alt) {
                      setState(() => Store.interface = l);
                      saveChoice('interface', l);
                    },
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
                    capitalize(Localization.get('learning')),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                for (final l in learning)
                  LanguageTile(
                    l,
                    mode: Store.learning == l
                        ? Store.alt
                            ? LanguageMode.main
                            : LanguageMode.alt
                        : LanguageMode.none,
                    onTap: (mode) {
                      setState(() {
                        Store.learning = l;
                        Store.alt = mode == LanguageMode.alt;
                      });
                      saveChoice('learning', l, alt: Store.alt);
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
