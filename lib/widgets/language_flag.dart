import 'dart:math';

import 'package:avdan/data/language.dart';
import 'package:flutter/material.dart';

class LanguageFlag extends StatelessWidget {
  const LanguageFlag(
    this.language, {
    this.offset = const Offset(0, 0),
    this.scale = 18,
  });
  final Language language;
  final Offset offset;
  final double scale;

  String? get flag =>
      language.flag == null ? null : 'assets/flags/${language.flag}.png';

  @override
  Widget build(BuildContext context) {
    if (flag == null) return Offstage();
    return Container(
      width: 16,
      height: 4,
      child: Transform.translate(
        offset: offset,
        child: Transform.rotate(
          angle: -pi / 4,
          child: Transform.scale(
            scale: scale,
            child: Image.asset(
              flag!,
              repeat: ImageRepeat.repeatX,
              // fit: BoxFit.contain,
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
    );
  }
}
