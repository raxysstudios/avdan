import 'package:freezed_annotation/freezed_annotation.dart';

part 'caption.freezed.dart';
part 'caption.g.dart';

@freezed
@JsonSerializable()
class Caption with _$Caption {
  const Caption({
    required this.main,
    this.alt,
  });

  @override
  final String main;
  @override
  final String? alt;

  factory Caption.fromJson(Map<String, Object?> json) =>
      _$CaptionFromJson(json);

  Map<String, Object?> toJson() => _$CaptionToJson(this);
}
