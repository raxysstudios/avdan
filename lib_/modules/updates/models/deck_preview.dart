import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../lib/modules/updates/models/deck_preview.freezed.dart';

enum DeckStatus { pending, downloading, unpacking, ready }

@unfreezed
class DeckPreview with _$DeckPreview {
  factory DeckPreview({
    required Pack pack,
    required Card cover,
    required int length,
    @Default(DeckStatus.pending) DeckStatus status,
    String? translation,
  }) = _DeckPreview;
}
