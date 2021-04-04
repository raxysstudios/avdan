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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Avdan",
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                Text(
                  " by Xoxag",
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
