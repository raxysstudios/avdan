import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../lib/models/translation.freezed.dart';
part '../../lib/models/translation.g.dart';

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
