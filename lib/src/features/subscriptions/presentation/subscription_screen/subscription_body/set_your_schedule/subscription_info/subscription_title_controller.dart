import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_info/subscription_info_controller.dart';

import '../../../../../../user_language/application/current_language.dart';

part 'subscription_title_controller.g.dart';

@riverpod
class SubscriptionTitleController extends _$SubscriptionTitleController {
  @override
  String build() {
    final interval = ref.watch(subscriptionInfoControllerProvider).interval;
    if (ref.watch(currentLanguageProvider) == 'ar') {
      return 'اشتراك ${interval.frequencyName}';
    } else {
      return 'My ${interval.frequencyName} Subscription';
    }
  }

  void setSubscriptionTitle(String value) => state = value;
}
