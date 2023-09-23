import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/checkout/presentation/checkout_body/saved_card_value_controller.dart';
import '../../data/checkout_repository.dart';
import '../../../../localization/current_language.dart';

import '../../domain/order/order.dart';
import '../../domain/payment/payment.dart';

part 'place_order_controller.g.dart';

@riverpod
class PlaceOrderController extends _$PlaceOrderController {
  @override
  FutureOr<PlaceOrderState> build() {
    return Initial();
  }

  void placeOrder(String quatationId) {
    final checkoutRepository = ref.watch(checkoutRepositoryProvider);
    final languageCode = ref.watch(currentLanguageProvider);
    final savedCardValue = ref.watch(savedCardValueControllerProvider);
    state = const AsyncLoading();
    checkoutRepository
        .palceOrder(quatationId, languageCode, savedCardValue ? 1 : 0)
        .then((value) {
      if (value is Order) {
        state = AsyncData(OrderPlaced(value));
      } else if (value is Payment) {
        if (value.postUrl != null) {
          state = AsyncData(
              SavedCard(quatationId: quatationId, url: value.postUrl!));
        } else {
          state = AsyncData(RedirectingToPaymentGateway(value));
        }
      }
    }).catchError((error, stackTrace) {
      state = AsyncError(error, stackTrace);
    });
  }
}

sealed class PlaceOrderState {}

class Initial extends PlaceOrderState {}

class OrderPlaced extends PlaceOrderState {
  final Order order;
  OrderPlaced(this.order);
}

class RedirectingToPaymentGateway extends PlaceOrderState {
  final Payment payment;
  RedirectingToPaymentGateway(this.payment);
}

class SavedCard extends PlaceOrderState {
  final String quatationId;
  final String url;
  SavedCard({required this.quatationId, required this.url});
}
