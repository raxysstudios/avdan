import 'dart:ui';

import 'package:avdan/models/caption.dart';
import 'package:avdan/shared/prefs.dart';

extension TitleCase on String? {
  String get titled {
    return this == null
        ? ''
        : this!
            .split(' ')
            .where((s) => s.isNotEmpty)
            .map((w) => w[0].toUpperCase() + w.substring(1))
            .join(' ')
            .split('-')
            .where((s) => s.isNotEmpty)
            .map((w) => w[0].toUpperCase() + w.substring(1))
            .join('-');
  }
}

extension GetText on Caption {
  String get get {
    return (Prefs.altScript ? alt : null) ?? main;
  }
}

extension BgColor on Color {
  Color get bg => withValues(alpha: 0.2);
}
