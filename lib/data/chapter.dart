import 'dart:math';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'translation.dart';

class Chapter {
  late final Translation title;
  late final bool alphabet;
  late final List<Translation> items;
  late final Color? color;

  Chapter(
    Iterable<Translation> items, {
    this.alphabet = false,
  }) {
    title = items.first;
    this.items = (alphabet ? _parseAlphabet(items.elementAt(1)) : items.skip(1))
        .toList();
    color = title.map['color'] == null
        ? null
        : Color(int.parse('0xff' + title.map['color']!)).withOpacity(0.25);
  }

  Iterable<Translation> _parseAlphabet(Translation alphabet) sync* {
    final languages = alphabet.map.keys.toList();
    final letters = alphabet.map.values.map((a) => a.split(' ')).toList();
    final length = letters.map((a) => a.length).reduce(max);

    for (var i = 0; i < length; i++) {
      final letter = Translation({});
      for (var j = 0; j < languages.length; j++)
        if (i < letters[j].length) letter.map[languages[j]] = letters[j][i];
      yield letter;
    }
  }

  factory Chapter.fromJson(dynamic json) {
    var items = (json as Iterable).map((i) => Translation.fromJson(i));
    return Chapter(
      items,
      alphabet: items.first.id == 'alphabet',
    );
  }

  String getImageURL(Translation item) {
    final root = 'assets/images/${title.id}/';
    final name =
        alphabet ? Store.learning.name.id! + '/' + item.learning! : item.id;
    return '$root$name.png';
  }
}
