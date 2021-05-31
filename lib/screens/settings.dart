import 'dart:async';
import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/data/translations.dart';
import 'package:avdan/widgets/about_card.dart';
import 'package:avdan/widgets/language_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _SettingsScreenState() {
    interfaceLanguages = List.from(languages.where((l) => l.interface));
    learningLanguages = List.from(languages.where((l) => l.learning));
    Timer(Duration(), loadLanguages);
  }

  List<Language> interfaceLanguages = [];
  List<Language> learningLanguages = [];

  loadLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    var il = findLanguage(
      prefs.getString('interfaceLanguage'),
    );
    var ll = findLanguage(
      prefs.getString('learningLanguage'),
    );

    await selectInterface(
      il ?? interfaceLanguages[0],
      prefs: prefs,
    );
    await selectLearning(
      ll ?? learningLanguages[0],
      prefs: prefs,
    );
  }

  selectInterface(Language l, {SharedPreferences? prefs}) async {
    setState(() => interfaceLanguage = l);
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    await prefs.setString('interfaceLanguage', l.name);
  }

  selectLearning(Language l, {SharedPreferences? prefs}) async {
    setState(() => learningLanguage = l);
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    await prefs.setString('learningLanguage', l.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          capitalize("Avdan"),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 4),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Interface language",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            LanguageList(
              interfaceLanguages,
              selected: interfaceLanguage,
              onSelect: selectInterface,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Learning language",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            LanguageList(
              learningLanguages,
              selected: learningLanguage,
              onSelect: selectLearning,
            ),
            Expanded(child: Container()),
            AboutCard(),
          ],
        ),
      ),
    );
  }
}
