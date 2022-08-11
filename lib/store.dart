import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

import 'shared/extensions.dart';

String? cachePath;

class Store with ChangeNotifier {
  late final Box<dynamic> prefs;
  late final Box<Map<String, dynamic>> decks;

  late Map<String, String> _localizations;
  void saveLocalizations(Map<String, String> data) {
    _localizations = data;
    prefs.put('localizations', data);
  }

  String localize(String key, [bool capitalized = true]) {
    var text = _localizations[key] ?? '';
    if (capitalized) text = capitalize(text);
    return text;
  }

  String get interface => prefs.get('interface', defaultValue: '') as String;
  set interface(String val) {
    prefs.put('interface', val);
    notifyListeners();
  }

  String get learning => prefs.get('learning', defaultValue: '') as String;
  set learning(String val) {
    prefs.put('learning', val);
    notifyListeners();
  }

  bool get alt => prefs.get('alt', defaultValue: false) as bool;
  set alt(bool val) {
    prefs.put('alt', val);
    notifyListeners();
  }

  Future<void> load() async {
    // if (!kIsWeb) {
    //   final dir = await getApplicationDocumentsDirectory();
    //   cachePath = '${dir.path}/static/';
    // }
    await Hive.initFlutter();
    prefs = await Hive.openBox<dynamic>('prefs');
    decks = await Hive.openBox<Map<String, dynamic>>('decks');
    await prefs.delete('lastUpdated');
    _localizations = prefs.get(
      'localizations',
      defaultValue: <String, String>{},
    ) as Map<String, String>;
    notifyListeners();
  }
}
