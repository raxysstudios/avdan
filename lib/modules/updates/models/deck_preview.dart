import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck_preview.freezed.dart';

@unfreezed
class DeckPreview with _$DeckPreview {
  factory DeckPreview({
    required Pack pack,
    required Card cover,
    required int length,
    int? loaded,
    String? translation,
  }) = _DeckPreview;
}
