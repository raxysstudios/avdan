import 'package:avdan/data/language.dart';
import 'package:avdan/audio-player.dart';
import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'label.dart';

class ItemView extends StatelessWidget {
  ItemView(this.translations, {this.text, this.actions});
  final Translations translations;
  final String? text;
  final Widget? actions;

  String get name => translations['english'] ?? '';
  String get image => 'assets/images/$name.png';
  String get audio => 'audio/${learningLanguage.name}/$name.mp3';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => playAsset(audio),
      child: Stack(
        children: [
          ...(text == null
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Label(
                      translations,
                      scale: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
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
                ]
              : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text?.toUpperCase() ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        text ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]),
          if (actions != null)
            Align(
              alignment: Alignment.topRight,
              child: actions,
            ),
        ],
      ),
    );
  }
}
