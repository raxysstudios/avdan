import 'dart:convert';
import 'store.dart';

class Language {
  Language({
    this.isInterface = false,
    this.isLearning = false,
    required this.translations,
  });
  final bool isInterface;
  final bool isLearning;
  final Map<String, String> translations;

  String get name => translations['english'] ?? 'null';
  String get nativeName => translations[name] ?? 'null';
  String get flag => 'assets/flags/$name.png';

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      isInterface: (json['isInterface'] ?? false) as bool,
      isLearning: (json['isLearning'] ?? false) as bool,
      translations: toMap(json["translations"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "isInterface": isInterface,
        "isLearning": isLearning,
        "translations": translations,
      };
}
