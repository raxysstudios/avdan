import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> interfaceLanguages = ["english", "turkish", "russian"];
  final List<String> learningLanguages = ["iron", "digor"];

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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  ),
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
            Container(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => TextButton(
                  onPressed: () =>
                      interfaceLanguage = interfaceLanguages[index],
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      capitalize(interfaceLanguages[index]),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: interfaceLanguages.length,
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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => TextButton(
                  onPressed: () => learningLanguage = learningLanguages[index],
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      capitalize(learningLanguages[index]),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: learningLanguages.length,
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
