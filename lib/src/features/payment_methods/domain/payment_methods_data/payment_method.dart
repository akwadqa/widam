import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/payment_methods/domain/payment_methods_data/saved_card.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

@freezed
class PaymentMethod with _$PaymentMethod {
  factory PaymentMethod({
    required String paymentMethodId,
    required int enabled,
    required String icon,
    required int priority,
    required String title,
    required String? gatewaySettings,
    required String? appleMerchantId,
    required String? postUrl,
    required String? paymentType,
    required String processor,
    required List<SavedCard>? savedCards,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}
