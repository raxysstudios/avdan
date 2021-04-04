import 'package:avdan/data/store.dart';
import 'package:avdan/widgets/language_card.dart';
import 'package:flutter/material.dart';
import 'chapters.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Text("Avdan", style: TextStyle(fontSize: 36)),
              Text("by Xoxag"),
              ListView.separated(
                itemCount: languages.length,
                itemBuilder: (context, index) => TextButton(
                  onPressed: () {
                    targetLanguage = languages[index]['english'] ?? '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChaptersScreen()),
                    );
                  },
                  child: LanguageCard(translations: languages[index]),
                ),
                separatorBuilder: (context, index) => Divider(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
