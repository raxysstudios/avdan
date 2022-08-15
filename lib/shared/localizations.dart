import 'package:avdan/shared/extensions.dart';
import 'package:hive/hive.dart';

late final Box<String> _strings;

Future<void> initLocalizations() async {
  _strings = await Hive.openBox<String>('localizations');
}

String localize(
  String key, {
  bool isTitled = true,
  Map<String, String>? map,
}) {
  final t = map?[key] ?? _strings.get(key) ?? '';
  return isTitled ? t.titled : t;
}

Future<void> putLocalizations(Map<String, String> data) {
  return _strings.putAll(data);
}
