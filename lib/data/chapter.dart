import 'dart:math';

import 'package:flutter/material.dart';

import 'translation.dart';

class Chapter {
  late final Translation title;
  late final bool alphabet;
  late final List<Translation> items;
  late final Color? color;

  String? get id => title.id;

  Chapter(
    List<Translation> items, {
    this.alphabet = false,
  }) {
    title = items.first;
    if (alphabet) {
      this.items = _parseAlphabet(items[1]);
    } else {
      this.items = items.skip(1).toList();
    }

    color = title.get('color') == null
        ? null
        : Color(int.parse('0xff' + title.get('color')!)).withOpacity(0.25);

    title.chapter = this;
    for (final item in items) {
      item.chapter = this;
    }
  }

  List<Translation> _parseAlphabet(Translation alphabet) {
    final languages = alphabet.keys.toList();
    final letters = alphabet.values.map((a) => a.split(' ')).toList();
    final length = letters.map((a) => a.length).reduce(max);

    return [
      for (var i = 0; i < length; i++)
        Translation({
          'english': i.toString(),
          for (var j = 0; j < languages.length; j++)
            if (i < letters[j].length) languages[j]: letters[j][i],
        }),
    ];
  }

  factory Chapter.fromJson(dynamic json) {
    final items = (json as Iterable).map((i) => Translation.fromJson(i));
    return Chapter(
      items.toList(),
      alphabet: items.first.id == 'alphabet',
    );
  }
}
