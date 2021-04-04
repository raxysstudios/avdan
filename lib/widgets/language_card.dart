import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  LanguageCard({required this.translations});
  final Map<String, String> translations;

  String get name => translations['english'] ?? '';
  String get native => translations['native'] ?? '';
  String get image => 'assets/flags/$name.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalize(native),
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    capitalize(name),
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
