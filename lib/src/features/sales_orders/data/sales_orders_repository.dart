import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/features/sales_orders/domain/orders_response/orders_response.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

import '../../../constants/end_points.dart';
import '../../cart/domain/cart/cart.dart';
import '../domain/processing_order/processing_order.dart';

part 'sales_orders_repository.g.dart';

@riverpod
SalesOrdersRepository salesOrderRepository(SalesOrderRepositoryRef ref) {
  return SalesOrdersRepository(ref.watch(networkServiceProvider()));
}

class SalesOrdersRepository {
  final NetworkService _networkService;

  SalesOrdersRepository(this._networkService);

  Future<AppResponse<OrdersResponse>> getPastOrders(int pageNo) async {
    final response =
        await _networkService.get(EndPoints.salesOrders, queryParameters: {
      // 'past_orders': 1,
      'page_no': pageNo,
    });

    AppResponse<OrdersResponse> appResponse = AppResponse.fromJson(
        response.data, (json) => OrdersResponse.fromJson(json));

    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }

    return appResponse;
  }

  Future<OrdersResponse> getOpenOrders() async {
    final response =
        await _networkService.get(EndPoints.salesOrders, queryParameters: {
      // 'open_orders': 1,
    });

    AppResponse<OrdersResponse> appResponse = AppResponse.fromJson(
        response.data, (json) => OrdersResponse.fromJson(json));

    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }

  Future<Cart> reorder(String salesOrderId) async {
    final response = await _networkService.put(EndPoints.reOrder,data:  {
      'sales_order_id': salesOrderId,
    });

    final AppResponse<Cart> cartResponse =
        AppResponse.fromJson(response.data, (json) => Cart.fromJson(json));
    if (cartResponse.error == 1) {
      throw AppException(cartResponse.message);
    }
    return cartResponse.data;
  }

  Future<ProcessingOrder> getProcessingOrder() async {
    final response = await _networkService.get(EndPoints.processingOrder);
    final AppResponse<ProcessingOrder> processingOrderResponse =
        AppResponse.fromJson(
            response.data, (json) => ProcessingOrder.fromJson(json));
    if (processingOrderResponse.error == 1) {
      throw AppException(processingOrderResponse.message);
    }
    return processingOrderResponse.data;
  }
}

@riverpod
FutureOr<ProcessingOrder> processingOrder(ProcessingOrderRef ref) {
  return ref.watch(salesOrderRepositoryProvider).getProcessingOrder();
}

@riverpod
FutureOr<OrdersResponse> openOrders(OpenOrdersRef ref) {
  return ref.watch(salesOrderRepositoryProvider).getOpenOrders();
}
