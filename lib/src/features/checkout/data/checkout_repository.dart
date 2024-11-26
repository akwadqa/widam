import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';
import '../domain/order/order.dart';
import '../domain/payment/payment.dart';
import '../../../network/network_service.dart';

part 'checkout_repository.g.dart';

@riverpod
CheckoutRepository checkoutRepository(CheckoutRepositoryRef ref) =>
    CheckoutRepository(ref.watch(networkServiceProvider()));

class CheckoutRepository {
  final NetworkService _networkService;

  CheckoutRepository(this._networkService);

  Future<dynamic> palceOrder(
      String quatationId, String languageCode, int createToken,
      [String? warehouseId]) async {
    final response = await _networkService.post(EndPoints.checkoutPlaceOrder, {
      'quotation_id': quatationId,
      '_lang': languageCode,
      'create_token': createToken,
      if (warehouseId != null) 'warehouse': warehouseId,
    });
    final data = response.data;
    AppResponse appResponse;
    if (data['data']['order_id'] != null) {
      appResponse =
          AppResponse<Order>.fromJson(data, (json) => Order.fromJson(json));
    } else {
      appResponse =
          AppResponse<Payment>.fromJson(data, (json) => Payment.fromJson(json));
    }
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }
}
