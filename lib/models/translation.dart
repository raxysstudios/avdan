import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'translation.freezed.dart';
part 'translation.g.dart';

@freezed
class Translation with _$Translation {
  const factory Translation({
    required String text,
    required String language,
    required String cardId,
  }) = _Translation;

  factory Translation.fromJson(Map<String, Object?> json) =>
      _$TranslationFromJson(json);
}
