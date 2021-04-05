import 'package:avdan/audio-player.dart';
import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'label.dart';

class ItemView extends StatelessWidget {
  ItemView({required this.translations});
  final Map<String, String> translations;

  String get name => translations['english'] ?? '';
  String get image => 'assets/images/$name.png';
  String get audio => 'audio/$learningLanguage/$name.mp3';

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => playAsset(audio),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                image,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) =>
                    Container(),
              ),
            ),
            Label(translations: translations),
          ],
        ),
      ),
    );
  }
}
