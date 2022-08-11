import 'package:avdan/models/caption.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters/timestamp_converter.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
class Language with _$Language {
  const factory Language({
    required String name,
    required Caption caption,
    required bool isInterface,
    @TimestampConverter() required DateTime lastUpdated,
    @Default(<String, String>{}) Map<String, String> localizations,
  }) = _Language;

  factory Language.fromJson(Map<String, Object?> json) =>
      _$LanguageFromJson(json);
}
