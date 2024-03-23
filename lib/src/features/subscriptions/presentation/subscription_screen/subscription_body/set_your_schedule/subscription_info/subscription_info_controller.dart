import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../domain/subscription.dart';
import '../../select_your_product/selected_subscription_items/selected_subscription_items_controller.dart';
import '../frequency_selector_form_field.dart';

part 'subscription_info_controller.g.dart';

@riverpod
class SubscriptionInfoController extends _$SubscriptionInfoController {
  @override
  Subscription build() {
    final items = ref.watch(selectedSubscriptionItemsControllerProvider);
    return Subscription(
      title: '',
      startDate: '',
      endDate: '',
      interval: Frequency.Daily,
      intervalCount: 1,
      timeSlotId: '',
      addressId: '',
      items: items,
    );
  }

  void setSubscriptionInfo(Subscription value) => state = value;
}
