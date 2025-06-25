import 'package:avdan/models/caption.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters/timestamp_converter.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
@JsonSerializable()
class Language with _$Language {
  const Language({
    required this.name,
    required this.caption,
    this.isInterface = false,
    this.contact,
    required this.lastUpdated,
    this.translations = const {},
  });

  @override
  final String name;
  @override
  final Caption caption;
  @override
  final bool isInterface;
  @override
  final String? contact;
  @override
  final Map<String, String> translations;
  @override
  @TimestampConverter()
  @override
  final DateTime lastUpdated;
  @override

  factory Language.fromJson(Map<String, Object?> json) =>
      _$LanguageFromJson(json);

  Map<String, Object?> toJson() => _$LanguageToJson(this);
}
