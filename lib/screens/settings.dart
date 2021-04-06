import 'dart:async';
import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/widgets/language-card.dart';
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

    Timer(Duration(milliseconds: 100), () async {
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
    await prefs.setString('inte  rfaceLanguage', l.name);
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
            fontSize: 36,
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Interface language",
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: Colors.black54,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 8),
            // Container(
            //   height: 42,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) => LanguageCard(
            //       interfaceLanguages[index],
            //       onTap: () => selectInterface(
            //         interfaceLanguages[index],
            //       ),
            //     ),
            //     separatorBuilder: (context, index) => SizedBox(width: 8),
            //     itemCount: interfaceLanguages.length,
            //   ),
            // ),
            SizedBox(height: 16),
            Text(
              "Learning language",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 64,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => LanguageCard(
                  learningLanguages[index],
                  onTap: () => selectLearning(
                    learningLanguages[index],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: learningLanguages.length,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 128,
              alignment: Alignment.center,
              child: Image.network(
                "https://sun9-65.userapi.com/impf/c622326/v622326572/49601/s7HngXH2MuY.jpg?size=755x1080&quality=96&sign=587244131770e7b03bd33f5330308110&type=album",
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              height: 64,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.free_breakfast),
                      label: Text(
                        "Donate",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.mail),
                      label: Text(
                        "Contact",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
