import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/checkout/data/payment_repository.dart';
import 'package:widam/src/features/checkout/domain/payment_result/payment_result.dart';

part 'custom_payment_controller.g.dart';

@riverpod
class CustomPaymentController extends _$CustomPaymentController {
  @override
  FutureOr<PaymentResult?> build() => null;

  PaymentRepository get _paymentRepository =>
      ref.watch(paymentRepositoryProvider);

  Future<void> payWithSavedCard(String url, String quatationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        _paymentRepository.payWithSavedCard(url: url, qutationId: quatationId));
  }

  Future<void> payWithAppleAndGooglePay(
      {required String url,
      required String quatationId,
      String? type,
      required String token}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        _paymentRepository.payWithAppleAndGooglePay(
            url: url, qutationId: quatationId, type: type, token: token));
  }
}
