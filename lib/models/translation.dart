import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation.freezed.dart';
part 'translation.g.dart';

@freezed
@JsonSerializable()
class Translation with _$Translation {
  const Translation({
    required this.text,
    required this.language,
    required this.cardId,
  });

  @override
  final String text;
  @override
  final String language;
  @override
  final String cardId;

  factory Translation.fromJson(Map<String, Object?> json) =>
      _$TranslationFromJson(json);

  Map<String, Object?> toJson() => _$TranslationToJson(this);
}
