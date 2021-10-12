import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'capitalize.dart';
import 'data/chapter.dart';
import 'data/language.dart';

typedef Dict<T> = Map<String, T>;

class Store with ChangeNotifier {
  Store();
  late final SharedPreferences _prefs;

  late final Dict<Dict<String>> _localization;
  String localize(String key) =>
      capitalize(_localization[key]?[interface.name.id]);

  late final List<Language> _languages;
  List<Language> get languages => _languages;

  static late final List<Chapter> _chapters;
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
      _prefs.getString('learning'),
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

  static Future<Dict<Dict<String>>> _loadLocalization(assetUrl) async {
    final data = await rootBundle
        .loadString(assetUrl)
        .then((t) => json.decode(t) as Dict);

    return {
      for (final term in data.entries)
        term.key: {
          for (final lang in (term.value as Dict).entries) lang.key: lang.value
        }
    };
  }

  static Future<List<Language>> _loadLanguages(assetUrl) async {
    final data = await rootBundle
        .loadString(assetUrl)
        .then((t) => json.decode(t) as List);

    final languages = data.map((j) => Language.fromJson(j)).toList();
    languages.sort((a, b) => a.name.id.compareTo(b.name.id));
    return languages;
  }

  static Future<List<Chapter>> _loadChapters(assetUrl) async {
    final data = await rootBundle
        .loadString(assetUrl)
        .then((t) => json.decode(t) as List);

    return data.map((j) => Chapter.fromJson(j)).toList();
  }
}
