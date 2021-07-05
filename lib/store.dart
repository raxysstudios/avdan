import 'dart:async' show Future;
import 'dart:convert';
import 'data/chapter.dart';
import 'data/language.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'data/translation.dart';

Future<void> initialize() async {
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

late List<Chapter> chapters = [];
late List<Language> languages = [];

Language learningLanguage = Language(Translation({}));
Language interfaceLanguage = Language(Translation({}));

Language? findLanguage(String? name) {
  try {
    return languages.firstWhere((l) => l.name.global == name);
  } catch (_) {
    return null;
  }
}
