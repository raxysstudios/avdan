import 'dart:convert';
import 'dart:math';
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
    var items = List.from(
      json["items"].map((i) => toMap(i)),
    ) as List<Translations>;
    if (translations['english'] == 'alphabet') {
      items = formAlphabets(items[0]);
      print(items);
    }
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
