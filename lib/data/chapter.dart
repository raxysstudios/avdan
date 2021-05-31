import 'dart:convert';
import 'dart:math';
import 'translations.dart';

class Chapter {
  Chapter({
    required this.translations,
    required this.items,
  });

  Chapter.alphabet({
    required this.translations,
    required Translations alphabet,
  }) {
    final languages = alphabet.keys.toList();
    final letters = alphabet.values.map((a) => a.split(' ')).toList();
    final length = letters.map((a) => a.length).reduce(max);

    final List<Translations> items = [];
    for (var i = 0; i < length; i++) {
      final Translations letter = {};
      for (var j = 0; j < languages.length; j++)
        if (i < letters[j].length) letter[languages[j]] = letters[j][i];
      items.add(letter);
    }
    this.items = items;
  }

  final Translations translations;
  late final List<Translations> items;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var translations = toMap(json["translations"]);
    var items = (json["items"] as Iterable<dynamic>).map(toMap).toList();

    return translations['english'] == 'alphabet'
        ? Chapter.alphabet(
            translations: translations,
            alphabet: items[0],
          )
        : Chapter(
            translations: translations,
            items: items,
          );
  }

  Map<String, dynamic> toJson() => {
        "translations": translations,
        "items": items,
      };
}
