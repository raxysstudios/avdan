import 'dart:async';
import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/settings/donate_button.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/segment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'language_tile.dart';

class SettingsScreen extends StatefulWidget {
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
        title: Center(
          child: Text(
            capitalize(Localization.get('settings')),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade50,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.home_outlined),
        label: Text(
          capitalize(Localization.get('home')),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          SegmentCard(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(Icons.landscape_outlined),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        Localization.get('honor'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DonateButton(),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => launch('https://t.me/alkaitagi'),
                            icon: Icon(Icons.send_outlined),
                            label:
                                Text(capitalize(Localization.get('contact'))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SegmentCard(
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
                  selected: Store.interface == l,
                  onTap: (_) {
                    setState(() => Store.interface = l);
                    saveChoice('interface', l);
                  },
                ),
            ],
          ),
          SegmentCard(
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
                  selected: Store.learning == l,
                  alt: l.alt != null && Store.learning == l && Store.alt,
                  onTap: (alt) {
                    setState(() {
                      Store.learning = l;
                      Store.alt = alt ?? false;
                    });
                    saveChoice('learning', l, alt: Store.alt);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
