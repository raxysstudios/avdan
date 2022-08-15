import 'package:hive_flutter/hive_flutter.dart';

late final Box<dynamic> _prefs;

Future<void> initPrefs() async {
  _prefs = await Hive.openBox<dynamic>('prefs');
}

String get lrnLng => _prefs.get('lrnLng') as String? ?? '';
set lrnLng(String v) => _prefs.put('lrnLng', v);

DateTime get lrnUpd => _prefs.get('lrnUpd') as DateTime? ?? DateTime(0);
set lrnUpd(DateTime? v) => _prefs.put('lrnUpd', v);

String get intLng => _prefs.get('intLng') as String? ?? '';
set intLng(String v) => _prefs.put('intLng', v);

DateTime get intUpd => _prefs.get('intUpd') as DateTime? ?? DateTime(0);
set intUpd(DateTime? v) => _prefs.put('intUpd', v);

DateTime get pstUpd => _prefs.get('pstUpd') as DateTime? ?? DateTime(0);
set pstUpd(DateTime? v) => _prefs.put('pstUpd', v);

bool get isAlt => _prefs.get('isAlt') as bool? ?? false;
set isAlt(bool v) => _prefs.put('isAlt', v);
