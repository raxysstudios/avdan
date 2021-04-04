import 'dart:convert';
import 'store.dart';

class Chapter {
  Chapter({
    required this.translations,
    required this.items,
  });
  final Map<String, String> translations;
  final List<Map<String, String>> items;

  factory Chapter.fromRawJson(String str) => Chapter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      translations: toMap(json["translations"]),
      items: List.from(
        json["items"].map((i) => toMap(i)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "translations": translations,
        "items": items,
      };
}
