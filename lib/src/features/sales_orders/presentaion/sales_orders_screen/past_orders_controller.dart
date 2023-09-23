import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/features/sales_orders/domain/orders_response/orders_response.dart';

import '../../data/sales_orders_repository.dart';

part 'past_orders_controller.g.dart';

@riverpod
class PastOrdersController extends _$PastOrdersController {
  SalesOrdersRepository get _salesOrdersRepository =>
      ref.watch(salesOrderRepositoryProvider);

  @override
  FutureOr<AppResponse<OrdersResponse>> build() {
    return _salesOrdersRepository.getPastOrders(1);
  }

  Future<bool> onLoading(int pageNo) async {
    if (pageNo > state.asData!.value.pagination!.totalPages) {
      return false;
    }
    try {
      final response = await _salesOrdersRepository.getPastOrders(pageNo);
      state = AsyncData(state.asData!.value.copyWith(
          data: state.asData!.value.data.copyWith(orders: [
        ...state.asData!.value.data.orders,
        ...response.data.orders
      ])));
      return true;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return false;
    }
  }
}