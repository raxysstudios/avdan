import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters/timestamp_converter.dart';

part '../../lib/models/post.freezed.dart';
part '../../lib/models/post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String title,
    required String body,
    @TimestampConverter() required DateTime created,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
