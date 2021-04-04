import 'package:avdan/data/store.dart';
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
              for (var language in ["digor", 'iron'])
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      capitalize(language),
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        targetLanguage = language;
                        return ChaptersScreen();
                      },
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
