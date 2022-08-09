import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/extensions.dart';

String? cachePath;

class Store with ChangeNotifier {
  late SharedPreferences _prefs;

  var _localizations = <String, String>{};
  void saveLocalizations(Map<String, String> data) {
    _localizations = data;
    _prefs.setString('localizations', json.encode(data));
  }

  void _loadLocalizations() {
    _localizations = json.decode(
      _prefs.getString('localizations') ?? '{}',
    ) as Map<String, String>;
  }

  String localize(String key, [bool capitalized = true]) {
    var text = _localizations[key] ?? '';
    if (capitalized) text = capitalize(text);
    return text;
  }

  late String _interface;
  String get interface => _interface;
  set interface(String val) {
    _interface = val;
    _prefs.setString('interface', val);
    notifyListeners();
  }

  late String _learning;
  String get learning => _learning;
  set learning(String val) {
    _learning = val;
    _prefs.setString('learning', val);
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
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      cachePath = '${dir.path}/static/';
    }
    _prefs = await SharedPreferences.getInstance();
    _alt = _prefs.getBool('alt') ?? false;
    _loadLocalizations();
    notifyListeners();
  }
}
