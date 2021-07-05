import 'dart:async';
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
  _SettingsScreenState() {
    interfaceLanguages = List.from(Store.languages.where((l) => l.interface));
    learningLanguages = List.from(Store.languages.where((l) => l.learning));
    Timer(Duration(), loadLanguages);
  }

  List<Language> interfaceLanguages = [];
  List<Language> learningLanguages = [];

  loadLanguages() async {
    final prefs = await SharedPreferences.getInstance();
    var il = Store.findLanguage(
      prefs.getString('interfaceLanguage'),
    );
    var ll = Store.findLanguage(
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
    setState(() => Store.interface = l);
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    await prefs.setString('interfaceLanguage', l.name.global!);
  }

  selectLearning(Language l, {SharedPreferences? prefs}) async {
    setState(() => Store.learning = l);
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    await prefs.setString('learningLanguage', l.name.global!);
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
              interfaceLanguages,
              selected: Store.interface,
              onSelect: selectInterface,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.hearing_outlined,
                size: 32,
              ),
            ),
            LanguageList(
              learningLanguages,
              selected: Store.learning,
              onSelect: selectLearning,
            ),
          ],
        ),
      ),
    );
  }
}
