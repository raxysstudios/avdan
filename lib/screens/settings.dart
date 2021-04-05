import 'package:avdan/data/store.dart';
import 'package:avdan/widgets/chips_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> interfaceLanguages = ["english", "turkish", "russian"];
  final List<String> learningLanguages = ["iron", "digor"];

  selectInterface(String l) => setState(() {
        interfaceLanguage = l;
      });

  selectLearning(String l) => setState(() {
        learningLanguage = l;
      });

  exit(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstLaunch', false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Avdan",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => exit(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Interface language",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            //   return ChoiceChip(
            //   label: Text('Item $index'),
            //   selected: _value == index,
            //   onSelected: (bool selected) {
            //     setState(() {
            //       _value = selected ? index : null;
            //     });
            //   },
            // );
            Container(
              height: 42,
              child: ChipsSelector(
                options: interfaceLanguages,
                selected: interfaceLanguage,
                setter: selectInterface,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Learning language",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 42,
              child: ChipsSelector(
                options: learningLanguages,
                selected: learningLanguage,
                setter: selectLearning,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 128,
              child: Image.network(
                "https://sun9-65.userapi.com/impf/c622326/v622326572/49601/s7HngXH2MuY.jpg?size=755x1080&quality=96&sign=587244131770e7b03bd33f5330308110&type=album",
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 64,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Contact",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Donate",
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
