import 'package:avdan/store.dart';

typedef Translations = Map<String, String>;

Translations toMap(dynamic map) {
  return Map.castFrom<String, dynamic, String, String>(
    map as Map<String, dynamic>,
  );
}

learning(Translations translations) {
  return translations[learningLanguage.name] ?? '';
}

interface(Translations translations) {
  return translations[interfaceLanguage.name] ?? '';
}

textOnly(Translations translations) {
  return translations['english'] == null;
}
