import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot.freezed.dart';
part 'time_slot.g.dart';

@freezed
class TimeSlot with _$TimeSlot {
  factory TimeSlot({
    required String timeSlotId,
    required String timeFormatted,
    required String? fromTime,
    required String? toTime,
    required num? maximumOrders,
    required int? timeslotOverload,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}
