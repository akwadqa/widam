import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_item.freezed.dart';
part 'coupon_item.g.dart';

@freezed
class CouponItem with _$CouponItem {
  factory CouponItem({
    required String itemName,
    required num qty,
    required num rate,
  }) = _CouponItem;

  factory CouponItem.fromJson(Map<String, dynamic> json) =>
      _$CouponItemFromJson(json);
}
