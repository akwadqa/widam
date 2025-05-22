import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/checkout/domain/order/order.dart';

part 'payment_result.freezed.dart';
part 'payment_result.g.dart';

@freezed
class PaymentResult with _$PaymentResult {
  factory PaymentResult(
      {required String message,
      required dynamic statusCode,
      required dynamic error,
      required bool paymentSuccess,
      required String statusMessage,
      required Order? soDetails,
      required String? pun}) = _PaymentResult;

  factory PaymentResult.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultFromJson(json);
}
