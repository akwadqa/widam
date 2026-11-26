import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/application/user_data_provider.dart';
import '../../../sales_orders/data/sales_orders_repository.dart';
import '../../../sales_orders/domain/orders_response/orders_response.dart';
import '../../../sales_orders/domain/processing_order/processing_order.dart';
import '../../../sales_orders/domain/sales_order/sales_order.dart';

part 'home_order_tracking_controller.g.dart';

/// The order shown in the home tracking card.
///
/// [statuses] is the ordered status list from the API and [currentStep] is
/// the index of the order's status in it.
typedef HomeActiveOrder = ({
  SalesOrder order,
  List<String> statuses,
  int currentStep,
});

/// What the home tracking card shows. [activeOrder] is `null` when the open
/// orders could not be loaded or matched: the card then shows the generic
/// "orders in progress" message, as the old card did.
class HomeOrderTracking {
  const HomeOrderTracking({this.activeOrder});

  final HomeActiveOrder? activeOrder;
}

/// `null` when the user has no order in progress (the card is hidden).
/// Visibility follows `processingOrder.hasProcessingOrders`, like the old
/// card; the open orders only add the details.
@riverpod
class HomeOrderTrackingController extends _$HomeOrderTrackingController {
  static const String _logTag = '[HomeOrderTracking]';

  @override
  FutureOr<HomeOrderTracking?> build() {
    // Guests never have orders: answer synchronously so no skeleton shows.
    final isLoggedIn = ref.watch(userDataProvider) != null;
    if (!isLoggedIn) return null;

    // Both requests start now, together with the home layout request,
    // instead of waiting for one another.
    final processingOrderFuture = ref.watch(processingOrderProvider.future);
    final openOrdersFuture = ref.watch(openOrdersProvider.future).then(
      (OrdersResponse? response) => response,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('$_logTag failed to load open orders: $error\n$stackTrace');
        return null;
      },
    );
    return _combine(processingOrderFuture, openOrdersFuture);
  }

  Future<HomeOrderTracking?> _combine(
    Future<ProcessingOrder?> processingOrderFuture,
    Future<OrdersResponse?> openOrdersFuture,
  ) async {
    final processingOrder = await processingOrderFuture;
    if (processingOrder?.hasProcessingOrders != true) return null;
    final ordersResponse = await openOrdersFuture;
    return HomeOrderTracking(
      activeOrder:
          ordersResponse == null ? null : _firstActiveOrder(ordersResponse),
    );
  }

  HomeActiveOrder? _firstActiveOrder(OrdersResponse ordersResponse) {
    final statuses = ordersResponse.ordersStatuses;
    final lastStep = statuses.length - 1;
    for (final order in ordersResponse.orders) {
      final step = statuses.indexOf(order.status);
      if (step >= 0 && step < lastStep) {
        return (order: order, statuses: statuses, currentStep: step);
      }
    }
    debugPrint(
      '$_logTag no matching order. statuses=$statuses, '
      'orders=${ordersResponse.orders.map((order) => order.status).toList()}',
    );
    return null;
  }
}
