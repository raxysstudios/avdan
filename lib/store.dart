import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/chapter.dart';
import 'models/language.dart';
import 'shared/extensions.dart' as cap;

typedef Dict<T> = Map<String, T>;

class Store with ChangeNotifier {
  Store();
  late SharedPreferences _prefs;
  late Dict<Dict<String>> _localization;
  String localize(String key, [bool capitalize = true]) {
    var text = _localization[key]?[interface.name.id] ?? '';
    if (capitalize) {
      text = cap.capitalize(text);
    }
    return text;
  }

  late List<Language> _languages;
  List<Language> get languages => _languages;

  late List<Chapter> _chapters;
  List<Chapter> get chapters => _chapters;

  late Language _interface;
  Language get interface => _interface;
  set interface(Language val) {
    _interface = val;
    _prefs.setString('interface', _interface.name.id);
    notifyListeners();
  }

  late Language _learning;
  Language get learning => _learning;
  set learning(Language val) {
    _learning = val;
    _prefs.setString('learning', _learning.name.id);
    notifyListeners();
  }

  late bool _alt;
  bool get alt => _alt;
  set alt(bool val) {
    _alt = val;
    _prefs.setBool('alt', _alt);
    notifyListeners();
  }

  Future<void> load() async {
    _localization = await _loadLocalization('assets/localization.json');
    _languages = await _loadLanguages('assets/languages.json');
    _chapters = await _loadChapters('assets/chapters.json');

    _prefs = await SharedPreferences.getInstance();
    _interface = _findLanguage(
      _prefs.getString('interface'),
      languages,
      languages.firstWhere((l) => l.interface),
    );
    _learning = _findLanguage(
      'iron',
      //_prefs.getString('learning'),
      languages,
      languages.firstWhere((l) => !l.interface),
    );
    _alt = _prefs.getBool('alt') ?? false;

    notifyListeners();
  }

  static Language _findLanguage(
    String? name,
    List<Language> languages,
    Language orElse,
  ) =>
      languages.firstWhere(
        (l) => l.name.id == name,
        orElse: () => orElse,
      );

  static Future<Dict<Dict<String>>> _loadLocalization(String assetUrl) async {
    final data = await rootBundle
        .loadString(assetUrl)
        .then((t) => json.decode(t) as Dict);

    return {
      for (final term in data.entries)
        term.key: {
          for (final lang in (term.value as Dict).entries)
            lang.key: lang.value as String
        }
    };
  }

  static Future<List<Language>> _loadLanguages(String assetUrl) async {
    final data = await rootBundle
        .loadString(assetUrl)
        .then((t) => json.decode(t) as List);

    final languages = data
        .map((dynamic j) => Language.fromJson(j as Map<String, dynamic>))
        .toList();
    // languages.sort((a, b) => a.name.id.compareTo(b.name.id));
    return languages;
  }

  static Future<List<Chapter>> _loadChapters(String assetUrl) async {
    final data = await rootBundle
        .loadString(assetUrl)
        .then((t) => json.decode(t) as List);

    return data.map((dynamic j) => Chapter.fromJson(j)).toList();
  }
}
