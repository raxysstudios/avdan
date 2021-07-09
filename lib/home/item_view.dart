import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/audio_player.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemView extends StatelessWidget {
  final Chapter chapter;
  final Translation item;
  final Widget? actions;

  ItemView({
    required this.chapter,
    required this.item,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => playItem(chapter, item),
      child: Stack(
        children: [
          if (item.global == null) ...[
            Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.learning!.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 96,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        item.learning!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 96,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ] else ...[
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 32,
                ),
                child: Image.asset(
                  chapter.getImageURL(item),
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
                titleSize: 32,
                subtitleSize: 26,
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
