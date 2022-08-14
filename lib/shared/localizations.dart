import 'package:hive/hive.dart';

import 'utils.dart';

late final Box<String> _strings;

Future<void> initLocalizations() async {
  _strings = await Hive.openBox<String>('localizations');
}

String localize(String key, [bool capitalized = true]) {
  var text = _strings.get(key) ?? '';
  if (capitalized) text = capitalize(text);
  return text;
}

Future<void> putLocalizations(Map<String, String> data) {
  return _strings.putAll(data);
}
