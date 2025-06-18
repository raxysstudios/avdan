import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters/color_converter.dart';
import 'converters/timestamp_converter.dart';

part 'pack.freezed.dart';
part 'pack.g.dart';

@freezed
@JsonSerializable()
class Pack with _$Pack {
  const Pack({
    required this.id,
    required this.coverId,
    required this.length,
    this.order = 0,
    this.color,
    required this.lastUpdated,
  });

  @override
  final String id;
  @override
  final String coverId;
  @override
  final int length;
  @override
  final int order;
  @ColorConverter()
  @override
  final Color? color;
  @TimestampConverter()
  @override
  final DateTime lastUpdated;

  factory Pack.fromJson(Map<String, Object?> json) => _$PackFromJson(json);

  Map<String, Object?> toJson() => _$PackToJson(this);
}
