import 'package:avdan/data/translations.dart';
import 'package:avdan/audio_player.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/label.dart';

class ItemView extends StatelessWidget {
  ItemView(this.translations, {this.actions});
  final Translations translations;
  final Widget? actions;

  String get name => translations['english'] ?? learning(translations);
  String get image => 'assets/images/$name.png';
  String get audio => 'assets/audio/${learningLanguage.name}/$name.mp3';

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
