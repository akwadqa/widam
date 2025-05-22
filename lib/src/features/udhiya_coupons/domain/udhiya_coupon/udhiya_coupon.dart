import 'package:freezed_annotation/freezed_annotation.dart';

import 'pickup_details.dart';

part 'udhiya_coupon.freezed.dart';
part 'udhiya_coupon.g.dart';

@freezed
class UdhiyaCoupon with _$UdhiyaCoupon {
  factory UdhiyaCoupon({
    required String couponId,
    required String status,
    required String salesInvoice,
    required String qrCode,
    required PickupDetails pickupDetails,
  }) = _UdhiyaCoupon;

  factory UdhiyaCoupon.fromJson(Map<String, dynamic> json) =>
      _$UdhiyaCouponFromJson(json);
}
