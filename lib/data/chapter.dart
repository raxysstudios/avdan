import 'dart:convert';
import 'dart:math';
import 'translations.dart';

class Chapter {
  Chapter({
    required this.translations,
    required this.items,
  });
  final Translations translations;
  final List<Translations> items;

  factory Chapter.fromRawJson(String str) => Chapter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static List<Translations> formAlphabets(Translations item) {
    final languages = item.keys.toList();
    final alphabets = item.values.map((a) => a.split(' ')).toList();
    final length = alphabets.map((a) => a.length).reduce(max);

    final List<Translations> items = [];
    for (var i = 0; i < length; i++) {
      final Translations letter = {};
      for (var j = 0; j < languages.length; j++)
        if (i < alphabets[j].length) letter[languages[j]] = alphabets[j][i];
      items.add(letter);
    }
    return items;
  }

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var translations = toMap(json["translations"]);
    var items =
        (json["items"] as Iterable<dynamic>).map((i) => toMap(i)).toList();
    if (translations['english'] == 'alphabet') items = formAlphabets(items[0]);
    return Chapter(
      translations: translations,
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
        "translations": translations,
        "items": items,
      };
}
