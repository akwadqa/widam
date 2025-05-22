import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_info/subscription_title_controller.dart';
import '../../../../../addresses/application/local_location_info.dart';
import '../../../../data/subscriptions_repository.dart';
import '../set_your_schedule/subscription_info/subscription_info_controller.dart';

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
      final subscriptionInfo = ref.watch(subscriptionInfoControllerProvider);
      final newSubscriptionInfo = subscriptionInfo.copyWith(
          title: ref.watch(subscriptionTitleControllerProvider));
      final warehouseId =
          ref.watch(localLocationInfoProvider).warehouseId;
      final appResponse = await subscriptionsRepository.addSubscription(
          newSubscriptionInfo, warehouseId);
      state = AsyncValue.data(appResponse.message);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
