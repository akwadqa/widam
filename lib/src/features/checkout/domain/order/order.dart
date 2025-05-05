import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  factory Order({
    required String orderId,
    required List<ItemDetails> websiteItems,
    required double subTotal,
    required double deliveryCharges,
    required double grandTotal,
    required String currency,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
