import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'shared/extensions.dart';

String? cachePath;

class Store with ChangeNotifier {
  late final Box<dynamic> prefs;
  late final Box<Map<String, dynamic>> decks;

  var _localizations = <String, String>{};
  void saveLocalizations(Map<String, String> data) {
    _localizations = data;
    prefs.put('localizations', data);
  }

  void _loadLocalizations() {
    _localizations = prefs.get(
      'localizations',
      defaultValue: <String, String>{},
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
    prefs.put('interface', val);
    notifyListeners();
  }

  late String _learning;
  String get learning => _learning;
  set learning(String val) {
    _learning = val;
    prefs.put('learning', val);
    notifyListeners();
  }

  late bool _alt;
  bool get alt => _alt;
  set alt(bool val) {
    _alt = val;
    prefs.put('alt', _alt);
    notifyListeners();
  }

  Future<void> load() async {
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      cachePath = '${dir.path}/static/';
    }
    prefs = await Hive.openBox<dynamic>('prefs');
    decks = await Hive.openBox<Map<String, dynamic>>('decks');
    _alt = prefs.get('alt', defaultValue: false) as bool;
    _loadLocalizations();
    notifyListeners();
  }
}
