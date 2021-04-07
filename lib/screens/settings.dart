import 'dart:async';
import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
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
    interfaceLanguages = List.from(languages.where((l) => l.isInterface));
    learningLanguages = List.from(languages.where((l) => l.isLearning));

    Timer(Duration(), () async {
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
    });
  }

  List<Language> interfaceLanguages = [];
  List<Language> learningLanguages = [];

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
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Text(
                "Interface language",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LanguageList(
              interfaceLanguages,
              selected: interfaceLanguage,
              onSelect: selectInterface,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Learning language",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  // fontWeight: FontWeight.bold,
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
