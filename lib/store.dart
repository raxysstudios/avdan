import 'dart:async' show Future;
import 'dart:convert';
import 'data/chapter.dart';
import 'data/language.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'data/translation.dart';

class Store {
  static Future<void> initialize() async {
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
  }

  static late List<Chapter> chapters = [];
  static late List<Language> languages = [];

  static Language learning = Language(Translation({}));
  static Language interface = Language(Translation({}));
  static bool alt = false;

  static Language? findLanguage(String? name) {
    try {
      return languages.firstWhere((l) => l.name.global == name);
    } catch (_) {
      return null;
    }
  }
}
