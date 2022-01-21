import 'package:flutter/cupertino.dart';

import 'translation.dart';

class Language {
  final Translation name;
  final String flag;
  final bool interface;

  String get id => name.id;
  String? get alt {
    final alt = name.id + '_alt';
    return name.get(alt) == null ? null : alt;
  }

  ImageProvider get flagImage => AssetImage('assets/flags/$flag.png');

  const Language(
    this.name, {
    required this.flag,
    this.interface = false,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      Translation.fromJson(json['name']),
      flag: json['flag'] as String,
      interface: (json['interface'] ?? false) as bool,
    );
  }
}
