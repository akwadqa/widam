import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/empty_orders_widget.dart';
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/past_orders_controller.dart';

import '../../../../common_widgets/app_pagination_widget.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../sales_order_item/sales_order_item.dart';

class PastOrders extends ConsumerWidget {
  const PastOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastOrdersAsync = ref.watch(pastOrdersControllerProvider);
    return pastOrdersAsync.when(
        data: (pastOrdersData) {
          final salesOrders = pastOrdersData.data.orders;
          if (salesOrders.isEmpty) {
            return const EmptyOrdersWidget();
          }
          return AppPaginationWidget(
            onLoading:
                ref.read(pastOrdersControllerProvider.notifier).onLoading,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return SalesOrderItem(
                      salesOrder: salesOrders[index],
                      statuses: pastOrdersData.data.ordersStatuses,
                      salesOrderType: SalesOrderType.past);
                },
                separatorBuilder: (_, index) => const SizedBox(height: 10),
                padding: const EdgeInsets.all(2.0),
                itemCount: salesOrders.length),
          );
        },
        error: (error, stackTrace) =>
            AppBanner(message: error.toString(), stackTrace: stackTrace),
        loading: () => const FadeCircleLoadingIndicator());
  }
}
