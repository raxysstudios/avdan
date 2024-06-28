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
    return (isAlt ? alt : null) ?? main;
  }
}
