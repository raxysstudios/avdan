import 'dart:math';
import 'package:avdan/data/language.dart';
import 'package:flutter/material.dart';

class LanguageFlag extends StatelessWidget {
  final Language language;
  final Offset offset;
  final double scale;

  const LanguageFlag(
    this.language, {
    Key? key,
    this.offset = const Offset(0, 0),
    this.scale = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 4,
      child: Transform.translate(
        offset: offset,
        child: Transform.rotate(
          angle: -pi / 4,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                language.flagUrl,
                repeat: ImageRepeat.repeatX,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
