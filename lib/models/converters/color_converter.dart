import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) => Color(int.parse('0xff$json'));

  @override
  String toJson(Color object) =>
      (0xFFFFFF & object.value).toRadixString(16).padLeft(6, '0');
}
