import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/sales_orders/data/sales_orders_repository.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_order_item/sales_order_item.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/empty_orders_widget.dart';

class OpenOrders extends ConsumerWidget {
  const OpenOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openOrdersResponseAsync = ref.watch(openOrdersProvider);
    return openOrdersResponseAsync.when(
        data: (openOrdersResponse) {
          final openOrders = openOrdersResponse.orders;
          if (openOrders.isEmpty) {
            return const EmptyOrdersWidget();
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                return SalesOrderItem(
                    salesOrderType: SalesOrderType.open,
                    salesOrder: openOrders[index],
                    statuses: openOrdersResponse.ordersStatuses);
              },
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              padding: const EdgeInsets.only(
                  top: 2.0, left: 2.0, right: 2.0, bottom: 40),
              itemCount: openOrders.length);
        },
        error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  AppBanner(message: error.toString(), stackTrace: stackTrace),
            ),
        loading: () => const FadeCircleLoadingIndicator());
  }
}
