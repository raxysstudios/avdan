import 'dart:async' show Future;
import 'dart:convert';
import 'chapter.dart';
import 'language.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> initialize() async {
  var text = await rootBundle.loadString('assets/chapters.json');
  List<dynamic> array = json.decode(text);
  chapters = List.from(
    array.map(
      (j) => Chapter.fromJson(j as Map<String, dynamic>),
    ),
  );

  text = await rootBundle.loadString('assets/languages.json');
  array = json.decode(text);
  languages = List.from(
    array.map(
      (j) => Language.fromJson(j as Map<String, dynamic>),
    ),
  );
  languages.sort((a, b) => a.name.compareTo(b.name));
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
