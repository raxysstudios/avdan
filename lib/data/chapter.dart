import 'dart:convert';
import 'store.dart';
import 'language.dart';

class Chapter {
  Chapter({
    required this.translations,
    required this.items,
  });
  final Translations translations;
  final List<Translations> items;

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
