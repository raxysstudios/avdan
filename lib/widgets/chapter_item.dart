import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';

class ChapterItem extends StatelessWidget {
  ChapterItem({required this.translations});
  final Map<String, String> translations;

  String get name => translations['english'] ?? '';
  String get image => 'assets/images/$name.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(image)),
            Label(translations: translations),
          ],
        ),
      ),
    );
  }
}
