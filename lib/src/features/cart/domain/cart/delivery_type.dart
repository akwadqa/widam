import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/common_models/coordinates/coordinates.dart';
import 'package:widam/src/features/app_data/domain/delivery_date/delivery_date.dart';

import '../../../items/domain/item_details/item_details.dart';
import '../../../time_slots/domain/geofence_details/time_slot.dart';

part 'delivery_type.freezed.dart';
part 'delivery_type.g.dart';

@freezed
class DeliveryType with _$DeliveryType {
  factory DeliveryType({
    required String deliveryMethodId,
    required String deliveryMethodTitle,
    required DeliveryDate deliveryDate,
    required TimeSlot timeSlot,
    required List<ItemDetails> websiteItems,
    required double deliveryCharges,
    required double subTotal,
    required Coordinates? coordinates,
      required String? pickupPointId, // Add this

  }) = _DeliveryType;

  factory DeliveryType.fromJson(Map<String, dynamic> json) =>
      _$DeliveryTypeFromJson(json);
}
