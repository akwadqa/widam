import 'package:freezed_annotation/freezed_annotation.dart';

import 'time_slot_group.dart';

part 'delivery_method.freezed.dart';
part 'delivery_method.g.dart';

@freezed
class DeliveryMethod with _$DeliveryMethod {
  factory DeliveryMethod({
    required String deliveryMethodId,
    required String type,
    required String deliveryMethodTitle,
    required num deliveryCharges,
    required num minimumOrderAmount,
    required TimeSlotGroup timeSlotGroup,
  }) = _DeliveryMethod;

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodFromJson(json);
}
