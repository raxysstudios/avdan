import 'dart:convert';

Map<String, String> toMap(dynamic map) =>
    Map.castFrom<String, dynamic, String, String>(
      map as Map<String, dynamic>,
    );

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
