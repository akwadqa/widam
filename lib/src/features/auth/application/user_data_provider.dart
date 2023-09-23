import 'package:fcm_config/fcm_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/notifications/application/notifications_service.dart';
import '../../../../main.dart';
import '../../../constants/keys.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  NotificationsService get _notificationsServiceProvider =>
      ref.read(notificationsServiceProvider);

  @override
  ({String token, String id, String fullName})? build() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final token = sharedPreferences.getString(Keys.userAccessToken);
    final id = sharedPreferences.getString(Keys.userId);
    final fullName = sharedPreferences.getString(Keys.userFullName);
    final userData = token != null && id != null && fullName != null
        ? (token: token, id: id, fullName: fullName)
        : null;
    if (userData != null) {
      _notificationsServiceProvider.subscribeFCMTopics();
    } else {
      _notificationsServiceProvider.subscribeMarketingNotifications();
    }
    return userData;
  }

  Future<void> setUserData(
      {required String token,
      required String id,
      required String fullName}) async {
    _notificationsServiceProvider.subscribeFCMTopics();
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    sharedPreferences.setString(Keys.userAccessToken, token);
    sharedPreferences.setString(Keys.userId, id);
    sharedPreferences.setString(Keys.userFullName, fullName);
    state = (token: token, id: id, fullName: fullName);
    final deviceToken = await FCMConfig.instance.messaging.getToken();
    if (deviceToken != null) {
      await ref
          .read(deviceTokenControllerProvider.notifier)
          .sendFCMToken(deviceToken, id);
    }
  }

  Future<void> removeUserData() async {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    await sharedPreferences.remove(Keys.userAccessToken);
    await sharedPreferences.remove(Keys.userId);
    await sharedPreferences.remove(Keys.userFullName);
    state = null;
    await _notificationsServiceProvider.unsubscribeFCMTopics();
  }
}
