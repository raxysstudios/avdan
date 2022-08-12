import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    Timestamp ts;
    if (json is Timestamp) {
      ts = json;
    } else {
      ts = Timestamp(
        json['_seconds'] as int,
        json['_nanoseconds'] as int,
      );
    }
    return ts.toDate();
  }

  @override
  dynamic toJson(DateTime object) {
    final timestamp = Timestamp.fromDate(object);
    return {
      '_seconds': timestamp.seconds,
      '_nanoseconds': timestamp.nanoseconds,
    };
  }
}
