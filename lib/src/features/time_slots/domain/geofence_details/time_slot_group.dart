import 'package:freezed_annotation/freezed_annotation.dart';

import 'date.dart';

part 'time_slot_group.freezed.dart';
part 'time_slot_group.g.dart';

@freezed
class TimeSlotGroup with _$TimeSlotGroup {
  factory TimeSlotGroup({
    required String timeSlotGroupId,
    required num? maxSalesOrder,
    required List<Date> dates,
  }) = _TimeSlotGroup;

  factory TimeSlotGroup.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotGroupFromJson(json);
}
