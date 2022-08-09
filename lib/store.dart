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
    _prefs = await SharedPreferences.getInstance();
    _alt = _prefs.getBool('alt') ?? false;

    notifyListeners();
  }
}
