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
  const factory Deck({
    required Pack pack,
    required Card cover,
    required List<Card> cards,
  }) = _Deck;

  Color? get color => pack.color?.withOpacity(0.25);

  factory Deck.fromJson(Map<String, Object?> json) => _$DeckFromJson(json);
}
