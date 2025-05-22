import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_charge.freezed.dart';
part 'delivery_charge.g.dart';

@freezed
class DeliveryCharge with _$DeliveryCharge {
  factory DeliveryCharge({
    required String deliveryMethodId,
    required String? deliveryMethodTitle,
    required double deliveryCharges,
    required String deliveryChargesAccount,
  }) = _DeliveryCharge;

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) =>
      _$DeliveryChargeFromJson(json);
}
