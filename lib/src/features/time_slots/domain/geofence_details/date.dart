import 'package:freezed_annotation/freezed_annotation.dart';

import 'time_slot.dart';

part 'date.freezed.dart';
part 'date.g.dart';

@freezed
class Date with _$Date {
  factory Date({
    required String date,
    required String dateFormatted,
    required List<TimeSlot> timeSlots,
  }) = _Date;

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);
}
