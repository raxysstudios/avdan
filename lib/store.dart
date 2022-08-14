import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Store with ChangeNotifier {
  late final Box<dynamic> prefs;

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
    await Hive.initFlutter();
    prefs = await Hive.openBox<dynamic>('prefs');

    notifyListeners();
  }
}
