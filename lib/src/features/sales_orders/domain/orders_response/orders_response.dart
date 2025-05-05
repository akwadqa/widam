import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart';

part 'orders_response.freezed.dart';
part 'orders_response.g.dart';

@freezed
class OrdersResponse with _$OrdersResponse {
  factory OrdersResponse({
    required List<SalesOrder> orders,
    required List<String> ordersStatuses,
  }) = _OrdersResponse;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);
}
