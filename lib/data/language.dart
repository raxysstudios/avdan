import 'dart:convert';
import 'store.dart';

class Language {
  Language({
    required this.name,
    required this.translations,
  });
  final String name;
  final Map<String, String> translations;

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] as String,
      translations: toMap(json["translations"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "translations": translations,
      };
}
