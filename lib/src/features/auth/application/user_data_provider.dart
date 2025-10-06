import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widam/src/features/notifications/application/notifications_service.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../constants/keys.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  NotificationsService get _notificationsServiceProvider =>
      ref.read(notificationsServiceProvider);

  SharedPreferences get _sharedPreferences =>
      ref.read(sharedPreferencesProvider).requireValue;

  @override
  ({String token, String id, String fullName, String customerId})? build() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider).requireValue;
    final token = sharedPreferences.getString(Keys.userAccessToken);
    final id = sharedPreferences.getString(Keys.userId);
    final customerId = sharedPreferences.getString(Keys.customerId);
    final fullName = sharedPreferences.getString(Keys.userFullName);
    final userData = token != null && id != null && fullName != null&& customerId != null
        ? (token: token, id: id, fullName: fullName,customerId:customerId)
        : null;
    if (userData != null) {
      _notificationsServiceProvider.subscribeOrdersTopic();
    } else {
      _notificationsServiceProvider.subscribeFCMTopics();
    }
    return userData;
  }

  Future<void> setUserData(
      {required String token,
      required String id,
      required String fullName,
      required String customerId,
      
      }) async {
    _notificationsServiceProvider.subscribeOrdersTopic();
    _sharedPreferences.setString(Keys.userAccessToken, token);
    _sharedPreferences.setString(Keys.userId, id);
    _sharedPreferences.setString(Keys.userFullName, fullName);
    _sharedPreferences.setString(Keys.customerId, customerId);
    state = (token: token, id: id, fullName: fullName,customerId:customerId);
    ref.read(notificationsServiceProvider).sendDeviceToken(id);
  }

  Future<void> removeUserData() async {
    await _sharedPreferences.remove(Keys.userAccessToken);
    await _sharedPreferences.remove(Keys.userId);
    await _sharedPreferences.remove(Keys.userFullName);
    await _sharedPreferences.remove(Keys.customerId);
    state = null;
    await _notificationsServiceProvider.unsubscribeOrdersTopic();
  }
    bool hasSeenAd() {
    return _sharedPreferences.getBool(Keys.firstTime) ?? false;
  }

  /// Mark the ad as seen
  Future<void> markAdAsSeen() async {
    await _sharedPreferences.setBool(Keys.firstTime, true);
  }
}
