import 'package:avdan/data/translations.dart';
import 'package:avdan/audio_player.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/label.dart';

class ItemView extends StatelessWidget {
  final String root;
  final Translations translations;
  final Widget? actions;
  ItemView({
    required this.root,
    required this.translations,
    this.actions,
  });

  String get file =>
      '$root/${translations['english'] ?? learning(translations)}';
  String get image => 'assets/images/$file.png';
  String get audio => 'assets/audio/${learningLanguage.name}/$file.mp3';

  @override
  Widget build(BuildContext context) {
    final text = learning(translations);
    return InkWell(
      onTap: () => playAsset(audio),
      child: Stack(
        children: [
          ...textOnly(translations)
              ? [
                  Center(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 96,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 96,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              : [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        image,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.bottomCenter,
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
                    padding: const EdgeInsets.all(8),
                    child: Label(
                      translations,
                      scale: 2,
                    ),
                  ),
                ],
          if (actions != null)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: actions,
              ),
            ),
        ],
      ),
    );
  }
}
