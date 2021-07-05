import 'dart:math';
import 'translation.dart';

class Chapter {
  late final Translation title;
  late final bool alphabet;
  late final List<Translation> items;

  Chapter(Iterable<Translation> items) {
    this.title = items.first;
    this.alphabet = false;
    this.items = items.skip(1).toList();
  }

  Chapter.alphabet(Iterable<Translation> items) {
    this.title = items.first;
    this.alphabet = true;

    final alphabet = items.elementAt(1);
    final languages = alphabet.map.keys.toList();
    final letters = alphabet.map.values.map((a) => a.split(' ')).toList();
    final length = letters.map((a) => a.length).reduce(max);

    this.items = [];
    for (var i = 0; i < length; i++) {
      final Translation letter = Translation({});
      for (var j = 0; j < languages.length; j++)
        if (i < letters[j].length) letter.map[languages[j]] = letters[j][i];
      this.items.add(letter);
    }
  }

  factory Chapter.fromJson(dynamic json) {
    var items = (json as Iterable).map((i) => Translation.fromJson(i));
    return items.first.global == 'alphabet'
        ? Chapter.alphabet(items)
        : Chapter(items);
  }

  String getImageURL(Translation item) {
    return 'assets/images/${title.global}/${item.global}.png';
  }
}
