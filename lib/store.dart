import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/language.dart';
import 'shared/extensions.dart' as cap;

typedef Dict<T> = Map<String, T>;

class Store with ChangeNotifier {
  Directory? _cache;
  late SharedPreferences _prefs;

  String localize(String key, [bool capitalize = true]) {
    var text = interface.localization[key] ?? '';
    if (capitalize) text = cap.capitalize(text);
    return text;
  }

  late Language _interface;
  Language get interface => _interface;
  set interface(Language val) {
    _interface = val;
    _prefs.setString('interface', json.encode(val.toJson()));
    notifyListeners();
  }

  late Language _learning;
  Language get learning => _learning;
  set learning(Language val) {
    _learning = val;
    _prefs.setString('learning', json.encode(val.toJson()));
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
    if (kIsWeb) _cache = await getApplicationDocumentsDirectory();
    _prefs = await SharedPreferences.getInstance();
    _alt = _prefs.getBool('alt') ?? false;

    notifyListeners();
  }
}
