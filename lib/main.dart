import 'dart:async';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widam/firebase_options.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/riverpod_observer.dart';

import 'src/app.dart';

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
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final canVibrate = await Vibrate.canVibrate;
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    canVibrateProvider.overrideWithValue(canVibrate),
    packageInfoProvider.overrideWithValue(packageInfo),
  ], observers: [
    RiverpodObserver()
  ], child: const App()));
}
