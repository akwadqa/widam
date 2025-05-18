import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/notifications/application/notifications_service.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/riverpod_observer.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(observers: [RiverpodObserver()]);
  await container.read(sharedPreferencesProvider.future);
  await container.read(canVibrateProvider.future);
  await container.read(packageInfoProvider.future);
  await container.read(notificationsServiceProvider).init();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(true);
  runApp(UncontrolledProviderScope(
      container: container, child: App(analytics: analytics)));
}