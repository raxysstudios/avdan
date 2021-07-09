import 'package:avdan/data/language.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'language_card.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  initState() {
    super.initState();
    interface = Store.languages.where((l) => l.interface).toList();
    learning = Store.languages.where((l) => l.learning).toList();
    saveChoice('interface', Store.interface);
    saveChoice('learning', Store.learning, alt: Store.alt);
  }

  late final List<Language> interface;
  late final List<Language> learning;
  SharedPreferences? prefs;

  Future<void> saveChoice(
    String index,
    Language language, {
    bool? alt,
  }) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setString(index, language.name.global!);
    if (alt != null) await prefs!.setBool('alt', alt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avdæn'),
        actions: [
          IconButton(
            onPressed: () => launch('https://t.me/alkaitagi'),
            icon: Icon(Icons.send_outlined),
            tooltip: 'Contact',
            visualDensity: VisualDensity(horizontal: 2),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Icon(Icons.landscape_outlined),
                  SizedBox(height: 8),
                  Text(
                    'Made with honor in\nOssetia & Dagestan, North Caucasus.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.visibility_outlined),
          ),
          Container(
            height: 112,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final l in interface)
                  LanguageCard(
                    l,
                    selected: Store.interface == l,
                    onTap: () {
                      setState(() => Store.interface = l);
                      saveChoice('interface', l);
                    },
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.hearing_outlined),
          ),
          Container(
            height: 112,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final l in learning)
                  LanguageCard(
                    l,
                    selected: Store.learning == l,
                    alt:
                        Store.learning == l && l.alt != null ? Store.alt : null,
                    onTap: () {
                      setState(() {
                        if (Store.learning != l) {
                          Store.learning = l;
                          Store.alt = false;
                        } else if (l.alt != null) Store.alt = !Store.alt;
                      });
                      saveChoice('learning', l, alt: Store.alt);
                    },
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
