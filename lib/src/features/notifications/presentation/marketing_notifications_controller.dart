import 'package:fcm_config/fcm_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/global_providers/global_providers.dart';

import '../../../constants/keys.dart';

part 'marketing_notifications_controller.g.dart';

@Riverpod(keepAlive: true)
class MarketingNotificationsController
    extends _$MarketingNotificationsController {
  @override
  bool build() {
    return ref.watch(sharedPreferencesProvider).getBool(Keys.marketing) ?? true;
  }

  Future<void> subscripeMarketingNotifications() async {
    await ref.read(sharedPreferencesProvider).setBool(Keys.marketing, true);
    await FCMConfig.instance.messaging.subscribeToTopic(Keys.marketing);
    state = true;
  }

  Future<void> unsubscripeMarketingNotifications() async {
    await ref.read(sharedPreferencesProvider).setBool(Keys.marketing, false);
    await FCMConfig.instance.messaging.unsubscribeFromTopic(Keys.marketing);
    state = false;
  }

  void onSwitchChanged(bool value) {
    value
        ? subscripeMarketingNotifications()
        : unsubscripeMarketingNotifications();
  }
}
