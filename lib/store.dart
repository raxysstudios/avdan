import 'dart:async' show Future;
import 'dart:convert';
import 'data/chapter.dart';
import 'data/language.dart';
import 'package:flutter/services.dart' show rootBundle;

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
    languages.sort((a, b) => a.name.compareTo(b.name));
  });
}

late List<Chapter> chapters = [];
late List<Language> languages = [];

Language _dummy = Language(translations: {'null': 'null'});
Language learningLanguage = _dummy;
Language interfaceLanguage = _dummy;

Language? findLanguage(String? name) {
  var l = languages.firstWhere(
    (l) => l.name == name,
    orElse: () => _dummy,
  );
  return l == _dummy ? null : l;
}
