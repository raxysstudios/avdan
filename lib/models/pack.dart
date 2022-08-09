import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters/color_converter.dart';
import 'converters/timestamp_converter.dart';

part 'pack.freezed.dart';
part 'pack.g.dart';

@freezed
class Pack with _$Pack {
  const factory Pack({
    @ColorConverter() @Default(Color(0x00000000)) Color color,
    @Default(DateTime.april) @TimestampConverter() DateTime lastUpdated,
  }) = _Pack;

  factory Pack.fromJson(Map<String, Object?> json) => _$PackFromJson(json);
}
