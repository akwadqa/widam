import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/cart/domain/cart/order_total/order_total.dart';
import 'package:widam/src/features/payment_methods/domain/payment_methods_data/saved_card.dart';
import '../../../addresses/domain/address/address.dart';
import '../../../payment_methods/domain/payment_methods_data/payment_method.dart';
import 'pickup/pickup.dart';

import 'cart_content.dart';
import 'delivery_charge.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  factory Cart({
    required String quotationId,
    required String date,
    required double total,
    required num totalQty,
    required double totalCharges,
    required double grandTotal,
    required int split,
    required PaymentMethod? paymentMethod,
    required SavedCard? savedCard,
    required int pickup,
    required int express,
    required Address? shippingAddressDetails,
    required String? couponCode,
    required double? totalDiscountAmount,
    required String currency,
    required int mubadara,
    required List<DeliveryCharge> deliveryCharges,
    required OrderTotal orderTotal,
    @_CartContentConverter() required dynamic cartContent,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

class _CartContentConverter implements JsonConverter<dynamic, dynamic> {
  const _CartContentConverter();

  @override
  dynamic fromJson(dynamic json) {
    if (json is List) {
      return json.map<Pickup>((e) => Pickup.fromJson(e)).toList();
    } else {
      return CartContent.fromJson(json);
    }
  }

  @override
  dynamic toJson(dynamic object) {}
}
