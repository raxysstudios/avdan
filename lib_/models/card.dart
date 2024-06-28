import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'caption.dart';

part '../../lib/models/card.freezed.dart';
part '../../lib/models/card.g.dart';

@freezed
class Card with _$Card {
  factory Card({
    required String id,
    required Caption caption,
    Caption? preview,
    String? imagePath,
    String? audioPath,
  }) = _Card;

  factory Card.fromJson(Map<String, Object?> json) => _$CardFromJson(json);
}
