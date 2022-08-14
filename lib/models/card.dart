import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'caption.dart';

part 'card.freezed.dart';
part 'card.g.dart';

@unfreezed
class Card with _$Card {
  factory Card({
    required String id,
    required Caption caption,
    String? imagePath,
    String? audioPath,
  }) = _Card;

  factory Card.fromJson(Map<String, Object?> json) => _$CardFromJson(json);
}
