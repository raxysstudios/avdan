import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/chapter.dart';
import 'data/language.dart';
import 'package:flutter/services.dart' show rootBundle;

class Store {
  static late List<Chapter> chapters = [];
  static late List<Language> languages = [];

  static late Language interface;
  static late Language learning;
  static bool alt = false;

  static Future<void> load() async {
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
      languages.sort((a, b) => a.name.global!.compareTo(b.name.global!));
    });

    final prefs = await SharedPreferences.getInstance();
    Store.interface = _findLanguage(
      prefs.getString('interface'),
      languages.firstWhere((l) => l.interface),
    );
    Store.learning = _findLanguage(
      prefs.getString('learning'),
      languages.firstWhere((l) => l.learning),
    );
  }

  static Language _findLanguage(String? name, Language orElse) {
    return languages.firstWhere(
      (l) => l.name.global == name,
      orElse: () => orElse,
    );
  }
}
