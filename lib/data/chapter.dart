import 'dart:math';
import 'translations.dart';

class Chapter {
  late final Translations title;
  late final List<Translations> items;

  Chapter(Iterable<Translations> items) {
    this.title = items.first;
    this.items = items.skip(1).toList();
  }

  Chapter.alphabet(Iterable<Translations> items) {
    this.title = items.first;

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

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var items = (json['items'] as Iterable<dynamic>).map(toMap).toList();
    return items.first['english'] == 'alphabet'
        ? Chapter.alphabet(items)
        : Chapter(items);
  }
}
