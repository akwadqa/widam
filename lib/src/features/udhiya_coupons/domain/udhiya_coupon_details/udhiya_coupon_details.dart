import 'package:freezed_annotation/freezed_annotation.dart';

import '../udhiya_coupon/pickup_details.dart';
import 'coupon_item.dart';

part 'udhiya_coupon_details.freezed.dart';
part 'udhiya_coupon_details.g.dart';

@freezed
class UdhiyaCouponDetails with _$UdhiyaCouponDetails {
  factory UdhiyaCouponDetails({
    required String couponId,
    required String status,
    required String salesInvoice,
    required String qrCode,
    required PickupDetails pickupDetails,
    required List<CouponItem>? couponItems,
  }) = _UdhiyaCouponDetails;

  factory UdhiyaCouponDetails.fromJson(Map<String, dynamic> json) =>
      _$UdhiyaCouponDetailsFromJson(json);
}
