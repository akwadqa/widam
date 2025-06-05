import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/payment_methods/domain/payment_methods_data/payment_method.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/network/services/dio_client.dart';
import 'package:widam/src/network/services/network_service.dart';

import '../../../common_models/response/app_response.dart';
import '../../../constants/end_points.dart';

part 'payment_methods_repository.g.dart';

@riverpod
PaymentMethodRepository paymentMethodRepository(
        PaymentMethodRepositoryRef ref) =>
    PaymentMethodRepository(ref.watch(networkServiceProvider()));

class PaymentMethodRepository {
  final NetworkService _networkService;
  PaymentMethodRepository(this._networkService);

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final response = await _networkService.get(EndPoints.paymentMethods);
    final AppResponse<List<PaymentMethod>> appResponse =
        AppResponse.fromJson(response.data, (json) {
      return (json['payment_methods'] as List)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList();
    });
    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }
    return appResponse.data;
  }
}

@riverpod
FutureOr<List<PaymentMethod>> paymentMethods(PaymentMethodsRef ref) {
  return ref.watch(paymentMethodRepositoryProvider).getPaymentMethods();
}
