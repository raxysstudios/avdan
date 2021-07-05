import 'package:avdan/data/language.dart';
import 'package:avdan/store.dart';
import 'package:avdan/settings/about_card.dart';
import 'package:avdan/settings/language_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  initState() {
    super.initState();
    interface = List.from(Store.languages.where((l) => l.interface));
    learning = List.from(Store.languages.where((l) => l.learning));
  }

  List<Language> interface = [];
  List<Language> learning = [];
  late final SharedPreferences? prefs;

  Future<void> saveChoice(Language language, String index) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs!.setString('interface', language.name.global!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Avdæn',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 4),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AboutCard(),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.visibility_outlined,
                size: 32,
              ),
            ),
            LanguageList(
              interface,
              selected: Store.interface,
              onSelect: (l) {
                setState(() => Store.interface = l);
                saveChoice(l, 'interface');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.hearing_outlined,
                size: 32,
              ),
            ),
            LanguageList(
              learning,
              selected: Store.learning,
              onSelect: (l) {
                setState(() => Store.learning = l);
                saveChoice(l, 'learning');
              },
            ),
          ],
        ),
      ),
    );
  }
}
