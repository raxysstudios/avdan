import 'dart:math';
import 'translations.dart';

class Chapter {
  late final Translations title;
  late final bool alphabet;
  late final List<Translations> items;

  Chapter(Iterable<Translations> items) {
    this.title = items.first;
    this.alphabet = false;
    this.items = items.skip(1).toList();
  }

  Chapter.alphabet(Iterable<Translations> items) {
    this.title = items.first;
    this.alphabet = true;

    final alphabet = items.elementAt(1);
    final languages = alphabet.keys.toList();
    final letters = alphabet.values.map((a) => a.split(' ')).toList();
    final length = letters.map((a) => a.length).reduce(max);

    this.items = [];
    for (var i = 0; i < length; i++) {
      final Translations letter = {};
      for (var j = 0; j < languages.length; j++)
        if (i < letters[j].length) letter[languages[j]] = letters[j][i];
      this.items.add(letter);
    }
  }

  factory Chapter.fromJson(dynamic json) {
    var items = (json as Iterable).map(toMap).toList();
    return items.first['english'] == 'alphabet'
        ? Chapter.alphabet(items)
        : Chapter(items);
  }

  String getImageURL(Translations item) {
    return 'assets/images/${title["english"]}/${item["english"]}.png';
  }
}
