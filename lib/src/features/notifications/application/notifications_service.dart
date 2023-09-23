import 'dart:io';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/features/notifications/presentation/marketing_notifications_controller.dart';
import 'package:widam/src/localization/current_language.dart';

import '../data/notifications_repository.dart';

part 'notifications_service.g.dart';

class NotificationsService {
  final Ref _ref;

  NotificationsService(this._ref);

  Future<void> subscribeFCMTopics() async {
    await FCMConfig.instance.messaging
        .subscribeToTopic(Platform.isIOS ? Keys.ios : Keys.android);
    await FCMConfig.instance.messaging.subscribeToTopic(Keys.orders);
    await FCMConfig.instance.messaging
        .subscribeToTopic(_ref.watch(currentLanguageProvider));
    subscribeMarketingNotifications();
  }

  void subscribeMarketingNotifications() {
    final isMarketingSubscribed =
        _ref.read(marketingNotificationsControllerProvider);
    if (isMarketingSubscribed) {
      _ref
          .read(marketingNotificationsControllerProvider.notifier)
          .subscripeMarketingNotifications();
    }
  }

  Future<void> unsubscribeFCMTopics() async {
    await FCMConfig.instance.messaging
        .unsubscribeFromTopic(Platform.isIOS ? Keys.ios : Keys.android);
    await FCMConfig.instance.messaging.unsubscribeFromTopic(Keys.orders);
  }
}

@riverpod
NotificationsService notificationsService(NotificationsServiceRef ref) {
  return NotificationsService(ref);
}

@riverpod
class DeviceTokenController extends _$DeviceTokenController {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> sendFCMToken(String token, String userId) async {
    state = const AsyncValue.loading();
    final NotificationsRepository notificationsRepository =
        ref.watch(notificationsRepositoryProvider);
    try {
      await notificationsRepository.sendFCMToken(token, userId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
