import 'package:freezed_annotation/freezed_annotation.dart';

import 'caption.dart';

part 'card.freezed.dart';
part 'card.g.dart';

@freezed
@JsonSerializable()
class Card with _$Card {
  const Card({
    required this.id,
    required this.caption,
    this.preview,
    this.imagePath,
    this.audioPath,
  });

  @override
  final String id;
  @override
  final Caption caption;
  @override
  final Caption? preview;
  @override
  final String? imagePath;
  @override
  final String? audioPath;

  factory Card.fromJson(Map<String, Object?> json) => _$CardFromJson(json);

  Map<String, Object?> toJson() => _$CardToJson(this);
}
