import 'dart:convert';

import 'package:avdan/models/language.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Prefs {
  Prefs._();

  static late final Box<dynamic> _prefs;

  static Future<void> init() async {
    _prefs = await Hive.openBox<dynamic>('prefs');
  }

  static String get interfaceLanguage => _prefs.get(
        'interfaceLanguage',
        defaultValue: '',
      );
  static set interfaceLanguage(String v) => _prefs.put(
        'interfaceLanguage',
        v,
      );

  static Language? _learningLanguage;
  static Language? get learningLanguage {
    if (_learningLanguage == null) {
      final json = _prefs.get('learningLanguage');
      if (json == null) return null;
      _learningLanguage = Language.fromJson(jsonDecode(json));
    }
    return _learningLanguage;
  }

  static set learningLanguage(Language? v) {
    _learningLanguage = v;
    _prefs.put(
      'learningLanguage',
      v == null ? null : jsonEncode(v.toJson()),
    );
  }

  static bool get altScript => _prefs.get(
        'altScript',
        defaultValue: false,
      );
  static set altScript(bool v) => _prefs.put(
        'altScript',
        v,
      );

  static DateTime get lastReadNews => _prefs.get(
        'lastReadNews',
        defaultValue: DateTime.fromMillisecondsSinceEpoch(0),
      );
  static set lastReadNews(DateTime v) => _prefs.put(
        'lastReadNews',
        v,
      );
}
