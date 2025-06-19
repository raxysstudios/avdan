import 'package:avdan/models/language.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:hive/hive.dart';

late final Box<String> _strings;

Future<void> initLocalizations() async {
  _strings = await Hive.openBox<String>('localizations');
}

Map<String, String> getLocalizations() {
  return {
    for (final k in _strings.keys) k as String: _strings.get(k) ?? '',
  };
}

String localize(
  String key, {
  bool isTitled = true,
  Map<String, String>? map,
}) {
  final t = (map == null ? _strings.get(key) : map[key]) ?? '';
  return isTitled ? t.titled : t;
}

Future<void> putLocalizations(Map<String, String> data) async {
  await _strings.clear();
  await _strings.putAll(data);
}

Future<void> selectUILanguage(Language language) async {
  intUpd = language.lastUpdated;
  intLng = language.name;

  await _strings.clear();
  await _strings.putAll(language.localizations);
}
