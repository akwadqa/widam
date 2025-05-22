import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_total.freezed.dart';
part 'order_total.g.dart';

@freezed
class OrderTotal with _$OrderTotal {
  factory OrderTotal({
    required double minimumOrderAmount,
    required double remainderAmount,
  }) = _OrderTotal;

  factory OrderTotal.fromJson(Map<String, dynamic> json) =>
      _$OrderTotalFromJson(json);
}
