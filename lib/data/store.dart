import 'dart:async' show Future;
import 'dart:convert';
import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/language.dart';
import 'package:flutter/services.dart' show rootBundle;

capitalize(String value) => value
    .split(' ')
    .where((w) => w.length > 0)
    .map((w) => w[0].toUpperCase() + w.substring(1))
    .join(' ');

Map<String, String> toMap(dynamic map) =>
    Map.castFrom<String, dynamic, String, String>(
      map as Map<String, dynamic>,
    );

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
  print(languages);
}

late List<Chapter> chapters = [];
late List<Language> languages = [];

String learningLanguage = "iron";
String interfaceLanguage = "english";
