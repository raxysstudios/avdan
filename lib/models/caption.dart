import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'caption.freezed.dart';
part 'caption.g.dart';

@freezed
class Caption with _$Caption {
  const factory Caption({
    required String main,
    String? alt,
  }) = _Caption;

  factory Caption.fromJson(Map<String, Object?> json) =>
      _$CaptionFromJson(json);
}
