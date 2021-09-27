import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/chapter.dart';
import 'data/language.dart';
import 'package:flutter/services.dart' show rootBundle;

class Localization {
  static late final Map<String, Map<String, String>> map;
  static String get(String key) {
    return map[key]?[Store.interface.name.id ?? 'english'] ?? '';
  }
}

class Store {
  static late final List<Chapter> chapters;
  static late final List<Language> languages;

  static late Language interface;
  static late Language learning;
  static bool alt = false;

  static Future<void> load() async {
    await rootBundle
        .loadString('assets/localization.json')
        .then((t) => json.decode(t) as Map<String, dynamic>)
        .then((l) {
      final Map<String, Map<String, String>> map = {};
      for (final k in l.entries) {
        map[k.key] = {};
        for (final t in (k.value as Map<String, dynamic>).entries) {
          map[k.key]![t.key] = t.value;
        }
      }
      Localization.map = map;
    });

    await rootBundle
        .loadString('assets/chapters.json')
        .then((t) => json.decode(t) as List)
        .then((l) {
      chapters = l.map((j) => Chapter.fromJson(j)).toList();
    });
    await rootBundle
        .loadString('assets/languages.json')
        .then((t) => json.decode(t) as List)
        .then((l) {
      languages = l.map((j) => Language.fromJson(j)).toList();
      languages.sort((a, b) => a.name.id!.compareTo(b.name.id!));
    });

    final prefs = await SharedPreferences.getInstance();
    Store.interface = _findLanguage(
      prefs.getString('interface'),
      languages.firstWhere((l) => l.interface),
    );
    Store.learning = _findLanguage(
      prefs.getString('learning'),
      languages.firstWhere((l) => !l.interface),
    );
    alt = prefs.getBool('alt') ?? false;
  }

  static Language _findLanguage(String? name, Language orElse) {
    return languages.firstWhere(
      (l) => l.name.id == name,
      orElse: () => orElse,
    );
  }
}
