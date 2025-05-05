import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/order_review/domain/order_review/order_review.dart';

import '../data/order_review_repository.dart';

part 'send_review_controller.g.dart';

@riverpod
class SendReviewController extends _$SendReviewController {
  @override
  FutureOr<OrderReview?> build() => null;

  Future<void> sendReview(OrderReview orderReview) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        ref.watch(orderReviewRepositoryProvider).sendOrderReview(orderReview));
  }
}
