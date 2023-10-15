import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widam/firebase_options.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/features/notifications/application/notifications_service.dart';

import 'src/app.dart';

part 'main.g.dart';

class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
    }
  }
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError();

@Riverpod(keepAlive: true)
bool canVibrate(CanVibrateRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
PackageInfo packageInfo(PackageInfoRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
IosDeviceInfo iosDeviceInfo(IosDeviceInfoRef ref) => throw UnimplementedError();

@riverpod
bool? hasCentralizedNotch(HasCentralizedNotchRef ref) {
  if (Platform.isIOS) {
    final deviceModel = ref.watch(iosDeviceInfoProvider).utsname.machine;
    return deviceModel.contains('15') || deviceModel.contains('16');
  }
  return null;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FCMConfig.instance.init(
    options: DefaultFirebaseOptions.currentPlatform,
    defaultAndroidChannel: const AndroidNotificationChannel(
      'high_importance_channel',
      'Fcm config',
      importance: Importance.high,
    ),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  bool canVibrate = await Vibrate.canVibrate;
  final userId = sharedPreferences.getString(Keys.userId);
  if (userId != null) {
    FCMConfig.instance.messaging.onTokenRefresh.listen((deviceToken) {
      DeviceTokenController().sendFCMToken(deviceToken, userId);
    });
  }
  IosDeviceInfo? iosInfo;
  if (Platform.isIOS) {
    final deviceInfo = DeviceInfoPlugin();
    iosInfo = await deviceInfo.iosInfo;
  }
  final packageInfo = await PackageInfo.fromPlatform();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  //!Branch SDK
  // FlutterBranchSdk.validateSDKIntegration();
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
    canVibrateProvider.overrideWith((ref) => canVibrate),
    packageInfoProvider.overrideWith((ref) => packageInfo),
    if (Platform.isIOS) iosDeviceInfoProvider.overrideWith((ref) => iosInfo!)
  ], observers: [
    RiverpodLogger()
  ], child: const App()));
}
