import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/common_models/coordinates/coordinates.dart';
import 'package:widam/src/features/time_slots/domain/geofence_details/time_slot.dart';

import '../../../time_slots/domain/geofence_details/date.dart';

part 'pickup_details.freezed.dart';
part 'pickup_details.g.dart';

@freezed
class PickupDetails with _$PickupDetails {
  factory PickupDetails({
    required String pickupPoint,
    required Date pickupDate,
    required TimeSlot pickupTimeSlot,
    required Coordinates coordinates,
  }) = _PickupDetails;

  factory PickupDetails.fromJson(Map<String, dynamic> json) =>
      _$PickupDetailsFromJson(json);
}
