import 'package:avdan/audio-player.dart';
import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'label.dart';

class ItemView extends StatelessWidget {
  ItemView(this.translations);
  final Map<String, String> translations;

  String get name => translations['english'] ?? '';
  String get image => 'assets/images/$name.png';
  String get audio => 'audio/${learningLanguage.name}/$name.mp3';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => playAsset(audio),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                image,
                fit: BoxFit.fitHeight,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) =>
                    Container(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Label(
              translations,
              scale: 2,
            ),
          ),
        ],
      ),
    );
  }
}
