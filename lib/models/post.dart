import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters/timestamp_converter.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
@JsonSerializable()
class Post with _$Post {
  const Post({
    required this.title,
    required this.body,
    required this.created,
  });

  @override
  final String title;
  @override
  final String body;
  @TimestampConverter()
  @override
  final DateTime created;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);

  Map<String, Object?> toJson() => _$PostToJson(this);
}
