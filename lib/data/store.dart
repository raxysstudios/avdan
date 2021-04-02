import 'dart:async' show Future;
import 'dart:convert';
import 'package:avdan/data/chapter.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> loadChapters() async {
  var text = await rootBundle.loadString('assets/chapters.json');
  List<Map<String, dynamic>> array = json.decode(text);
  chapters = List<Chapter>.from(array.map((x) => Chapter.fromJson(x)));
}

List<Chapter> chapters = [];
