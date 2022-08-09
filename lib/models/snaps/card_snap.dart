import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../caption.dart';

part 'card_snap.freezed.dart';
part 'card_snap.g.dart';

@freezed
class CardSnap with _$CardSnap {
  const factory CardSnap({
    required String id,
    required Caption caption,
    required String translation,
  }) = _CardSnap;

  factory CardSnap.fromJson(Map<String, Object?> json) =>
      _$CardSnapFromJson(json);
}
