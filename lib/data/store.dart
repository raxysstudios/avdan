import 'dart:async' show Future;
import 'dart:convert';
import 'package:avdan/data/chapter.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> loadChapters() async {
  var text = await rootBundle.loadString('assets/chapters.json');
  List<dynamic> array = json.decode(text);
  chapters = List.from(
    array.map(
      (j) => Chapter.fromJson(j as Map<String, dynamic>),
    ),
  );
}

late List<Chapter> chapters = [];

String targetLanguage = "iron";
String interfaceLanguage = "english";

capitalize(String value) => value
    .split(' ')
    .where((w) => w.length > 0)
    .map((w) => w[0].toUpperCase() + w.substring(1))
    .join(' ');
