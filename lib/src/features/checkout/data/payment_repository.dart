import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/network/network_service.dart';

import '../domain/payment_result/payment_result.dart';

part 'payment_repository.g.dart';

@riverpod
PaymentRepository paymentRepository(PaymentRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  final newDio = Dio(dio.options.copyWith(baseUrl: ''));
  newDio.interceptors.addAll(dio.interceptors);

  final NetworkService networkService =
      ref.watch(networkServiceProvider(newDio));

  return PaymentRepository(networkService);
}

class PaymentRepository {
  final NetworkService _networkService;

  PaymentRepository(this._networkService);

  Future<PaymentResult> payWithSavedCard(
      {required String url, required String qutationId}) async {
    final response =
        await _networkService.post(url, {'quotation_id': qutationId});
    PaymentResult paymentResult = PaymentResult.fromJson(response.data);
    return paymentResult;
  }

  Future<PaymentResult> payWithAppleAndGooglePay(
      {required String url,
      required String qutationId,
      String? type,
      required token}) async {
    final response = await _networkService.post(url, {
      'quotation_id': qutationId,
      if (type != null) 'type': '00$type',
      if (type != null) 'transaction_type': '1',
      'fluid_data_value': token
    });
    PaymentResult paymentResult = PaymentResult.fromJson(response.data);
    return paymentResult;
  }
}
