import 'package:avdan/store.dart';

typedef Translations = Map<String, String>;

Translations toMap(dynamic map) {
  return Map.castFrom<String, dynamic, String, String>(
    map as Map<String, dynamic>,
  );
}

String learning(Translations translations) {
  return translations[learningLanguage.globalName] ?? 'null';
}

String interface(Translations translations) {
  return translations[interfaceLanguage.globalName] ?? 'null';
}

bool textOnly(Translations translations) {
  return translations['english'] == null;
}
