import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../items/domain/item_details/item_details.dart';
import '../../../../time_slots/domain/geofence_details/time_slot.dart';

part 'pickup.freezed.dart';
part 'pickup.g.dart';

@freezed
class Pickup with _$Pickup {
  factory Pickup({
    required String pickupPointId,
    required String pickupPointName,
    required String warehouse,
    required String timeSlotGroup,
    required TimeSlot timeSlot,
    required String location,
    required String description,
    required String fromTime,
    required String toTime,
    required String address,
    required List<ItemDetails> websiteItems,
    required double deliveryCharges,
    required double subTotal,
  }) = _Pickup;

  factory Pickup.fromJson(Map<String, dynamic> json) => _$PickupFromJson(json);
}
