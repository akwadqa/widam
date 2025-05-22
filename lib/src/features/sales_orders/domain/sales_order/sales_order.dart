import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/address.dart';
import 'package:widam/src/features/app_data/domain/delivery_date/delivery_date.dart';
import 'package:widam/src/features/cart/domain/cart/delivery_charge.dart';
import 'package:widam/src/features/sales_orders/domain/sales_order/delivery_trip/delivery_trip.dart';

import 'item.dart';

part 'sales_order.freezed.dart';
part 'sales_order.g.dart';

@freezed
class SalesOrder with _$SalesOrder {
  factory SalesOrder(
      {required String salesOrderId,
      required String salesOrderDate,
      required DeliveryDate deliveryDate,
      required String time,
      required String status,
      required double grandTotal,
      required String currency,
      required List<DeliveryCharge> deliveryCharges,
      required List<Item> items,
      required Address address,
      required DeliveryTrip? deliveryTrip}) = _SalesOrder;

  factory SalesOrder.fromJson(Map<String, dynamic> json) =>
      _$SalesOrderFromJson(json);
}
