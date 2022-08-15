import 'package:avdan/shared/extensions.dart';
import 'package:hive/hive.dart';

late final Box<String> _strings;

Future<void> initLocalizations() async {
  _strings = await Hive.openBox<String>('localizations');
}

String localize(String key, [bool isTitle = true]) {
  var text = _strings.get(key) ?? '';
  if (isTitle) text = text.titled;
  return text;
}

Future<void> putLocalizations(Map<String, String> data) {
  return _strings.putAll(data);
}
