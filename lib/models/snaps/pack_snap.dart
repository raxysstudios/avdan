import 'package:avdan/models/pack.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'card_snap.dart';

part 'pack_snap.freezed.dart';
part 'pack_snap.g.dart';

@freezed
class PackSnap with _$PackSnap {
  const PackSnap._();
  const factory PackSnap({
    required String id,
    required Pack pack,
    required CardSnap cover,
    required Map<String, CardSnap> cards,
  }) = _PackSnap;

  String getAudioPath(CardSnap card) {
    return '$id/${card.id}.mp3';
  }

  String getImagePath(CardSnap card) {
    return '$id/${card.id}.png';
  }

  factory PackSnap.fromJson(Map<String, Object?> json) =>
      _$PackSnapFromJson(json);
}
