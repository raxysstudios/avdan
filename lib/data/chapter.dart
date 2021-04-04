import 'dart:convert';

class Chapter {
  Chapter({
    required this.translations,
    required this.items,
  });

  final Map<String, String> translations;
  final List<Map<String, String>> items;

  factory Chapter.fromRawJson(String str) => Chapter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
      translations: json["translations"],
      items: json["items"] as List<Map<String, String>>);

  Map<String, dynamic> toJson() => {
        "translations": translations,
        "items": items,
      };
}
