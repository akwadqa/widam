import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/app_data/domain/delivery_date/delivery_date.dart';
import 'package:widam/src/common_models/coordinates/coordinates.dart';
import 'package:widam/src/features/cart/domain/cart/delivery_type.dart';
import '../../../../items/domain/item_details/item_details.dart';
import '../../../../time_slots/domain/geofence_details/time_slot.dart';

part 'pickup.freezed.dart';
part 'pickup.g.dart';

@freezed
class Pickup with _$Pickup {
  const Pickup._();

  factory Pickup({
    required String pickupPointId,
    required String pickupPointName,
    required String warehouse,
    required String timeSlotGroup,
    required String deliveryMethod,
    required TimeSlot timeSlot,
    required String location,
    required String description,
    required String address,
    required List<ItemDetails> websiteItems,
    required DeliveryDate deliveryDate,
    required double deliveryCharges,
    required double subTotal,
    required Coordinates coordinates,
  }) = _Pickup;

  factory Pickup.fromJson(Map<String, dynamic> json) => _$PickupFromJson(json);

  DeliveryType toDeliveryType() {
    return DeliveryType(
      deliveryMethodId: deliveryMethod,
      deliveryMethodTitle: pickupPointName,
      deliveryDate: deliveryDate,
      timeSlot: timeSlot,
      websiteItems: websiteItems,
      deliveryCharges: deliveryCharges,
      subTotal: subTotal,
      coordinates: coordinates,
    );
  }
}
