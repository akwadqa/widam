import 'package:freezed_annotation/freezed_annotation.dart';

import 'delivery_type.dart';

part 'cart_content.freezed.dart';
part 'cart_content.g.dart';

@freezed
class CartContent with _$CartContent {
  factory CartContent({
    required DeliveryType? normalDelivery,
    required DeliveryType? expressDelivery,
    required DeliveryType? pickupDelivery,
  }) = _CartContent;

  factory CartContent.fromJson(Map<String, dynamic> json) =>
      _$CartContentFromJson(json);
}