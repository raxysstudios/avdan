import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translations.dart';
import 'package:avdan/audio_player.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemView extends StatelessWidget {
  final Chapter chapter;
  final Translations item;
  final Widget? actions;

  ItemView({
    required this.chapter,
    required this.item,
    this.actions,
  });

  String get root => chapter.title['english']!;
  String get file => '$root/${item['english'] ?? learning(item)}';
  String get image => 'assets/images/$file.png';

  @override
  Widget build(BuildContext context) {
    final text = learning(item);
    return InkWell(
      onTap: () => playItem(chapter, item),
      child: Stack(
        children: [
          ...textOnly(item)
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
                      item,
                      scale: 2,
                    ),
                  ),
                ],
          if (actions != null)
            Align(
              alignment: Alignment.bottomLeft,
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
