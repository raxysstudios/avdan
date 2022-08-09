import 'package:avdan/models/pack.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'card_snap.dart';

part 'pack_snap.freezed.dart';
part 'pack_snap.g.dart';

@freezed
class PackSnap with _$PackSnap {
  const factory PackSnap({
    required String id,
    required Pack pack,
    required Map<String, CardSnap> cards,
  }) = _PackSnap;

  factory PackSnap.fromJson(Map<String, Object?> json) =>
      _$PackSnapFromJson(json);
}
