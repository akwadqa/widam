import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/subscriptions_repository.dart';
import 'subscription_title.dart';

import '../set_your_schedule/set_your_schedule.dart';

part 'send_subscription_controller.g.dart';

@riverpod
class SendSubscriptionAsync extends _$SendSubscriptionAsync {
  @override
  FutureOr<String?> build() async => null;

  Future<void> sendSubscription() async {
    state = const AsyncValue.loading();
    try {
      final SubscriptionsRepository subscriptionsRepository =
          ref.watch(subscriptionsRepositoryProvider);
      final subscriptionInfo = ref.watch(subscriptionInfoProvider);
      final newSubscriptionInfo = subscriptionInfo.copyWith(
          title: ref.watch(subscriptionTitleProvider));
      final appResponse =
          await subscriptionsRepository.addSubscription(newSubscriptionInfo);
      state = AsyncValue.data(appResponse.message);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
