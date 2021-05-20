import 'dart:convert';
import 'store.dart';

typedef Translations = Map<String, String>;

class Language {
  Language({
    this.interface = false,
    this.learning = false,
    required this.translations,
  });
  final bool interface;
  final bool learning;
  final Translations translations;

  String get name => translations['english'] ?? 'null';
  String get nativeName => translations[name] ?? 'null';
  String get flag => 'assets/flags/$name.png';

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      interface: (json['interface'] ?? false) as bool,
      learning: (json['learning'] ?? false) as bool,
      translations: toMap(json["translations"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "isInterface": interface,
        "isLearning": learning,
        "translations": translations,
      };
}
