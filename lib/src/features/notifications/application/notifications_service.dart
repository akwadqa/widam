import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widam/firebase_options.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/features/notifications/presentation/marketing_notifications_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/localization/current_language.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../data/notifications_repository.dart';

part 'notifications_service.g.dart';

class NotificationsService {
  final Ref _ref;

  NotificationsService(this._ref);

  SharedPreferences get _sharedPreferences =>
      _ref.read(sharedPreferencesProvider).requireValue;

  Future<void> init() async {
    await FCMConfig.instance.init(
      options: DefaultFirebaseOptions.currentPlatform,
      defaultAndroidChannel: const AndroidNotificationChannel(
        'high_importance_channel',
        'Fcm config',
        importance: Importance.high,
      ),
    );
    final userId = _sharedPreferences.getString(Keys.userId);
    if (userId != null) {
      FCMConfig.instance.messaging.onTokenRefresh.listen((deviceToken) {
        _ref
            .read(deviceTokenControllerProvider.notifier)
            .sendFCMToken(deviceToken, userId);
      });
    }
  }

  Future<void> setupInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(message: initialMessage, context: context);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) =>
        _handleMessage(message: remoteMessage, context: context));
  }

  void _handleMessage(
      {required RemoteMessage message, required BuildContext context}) {
    final linkType = message.data['link_type'];
    final resourceId = message.data['resource_id'];
    if (linkType == 'Product') {
      context.router.push(ItemDetailsScreen(itemId: resourceId));
    } else if (linkType == 'Category') {
      context.router.push(ItemGroupScreen(itemGroupId: resourceId));
    }
  }

  void sendDeviceToken(String userId) async {
    final deviceToken = await FCMConfig.instance.messaging.getToken();
    if (deviceToken != null) {
      await _ref
          .read(deviceTokenControllerProvider.notifier)
          .sendFCMToken(deviceToken, userId);
    }
  }

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

@Riverpod(keepAlive: true)
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
