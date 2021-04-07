import 'dart:math';

import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/check_mark.dart';
import 'package:avdan/widgets/language_title.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(this.language, {this.selected = false, this.onTap});
  final Language language;
  final bool selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 192,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Transform.translate(
                  offset: Offset(64, 0),
                  child: Container(
                    width: 256,
                    height: 48,
                    child: Transform.rotate(
                      angle: -pi / 4,
                      child: Transform.scale(
                        scale: 1.5,
                        child: Image.asset(
                          language.flag,
                          repeat: ImageRepeat.repeatX,
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) =>
                              Container(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LanguageTitle(language),
              ),
              if (selected) CheckMark()
            ],
          ),
        ),
      ),
    );
  }
}
