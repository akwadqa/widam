import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_order_item/sales_order_item.dart';

@RoutePage()
class SalesOrderDetailsScreen extends StatelessWidget {
  const SalesOrderDetailsScreen(
      {super.key, required this.salesOrder, required this.statuses});
  final SalesOrder salesOrder;
  final List<String> statuses;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).salesOrderDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SalesOrderItem(
            salesOrder: salesOrder,
            statuses: statuses,
            salesOrderType: SalesOrderType.open),
      ),
    );
  }
}
