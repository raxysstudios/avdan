import 'package:avdan/data/store.dart';

typedef Translations = Map<String, String>;

Translations toMap(dynamic map) {
  return Map.castFrom<String, dynamic, String, String>(
    map as Map<String, dynamic>,
  );
}

translationPair(Translations translations) {
  return [
    translations[learningLanguage.name] ?? '',
    translations[interfaceLanguage.name] ?? ''
  ];
}

textOnly(Translations translations) {
  return translations['english'] == 'null';
}

capitalize(String value) => value
    .split(' ')
    .where((w) => w.length > 0)
    .map((w) => w[0].toUpperCase() + w.substring(1))
    .join(' ');
