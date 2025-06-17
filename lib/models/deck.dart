import 'dart:ui';

import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck.freezed.dart';
part 'deck.g.dart';

@unfreezed
class Deck with _$Deck {
  const Deck._();
  factory Deck({
    required Pack pack,
    required Card cover,
    required List<Card> cards,
    @Default(<String, String>{}) Map<String, String?> translations,
  }) = _Deck;

  Color? get color => pack.color?.withValues(alpha: 0.2);

  bool isOutdated(DateTime check) {
    return pack.lastUpdated.isBefore(check);
  }

  String translate(Card card) {
    return translations[card.id] ?? '';
  }

  factory Deck.fromJson(Map<String, Object?> json) => _$DeckFromJson(json);
}
