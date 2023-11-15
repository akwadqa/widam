import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/layouts/data/layouts_repository.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../addresses/application/geofence_id_controller.dart';

import '../../application/app_data_controller.dart';

part 'app_initial_controller.g.dart';

@riverpod
class AppInitialController extends _$AppInitialController {
  @override
  FutureOr<AppInitialResult> build() => _initial();

  Future<AppInitialResult> _initial() async {
    if (ref.watch(geofenceIdAndCoordinatesProvider).geofenceId != null) {
      final startTime = DateTime.now();
      await ref.read(appDataControllerProvider.notifier).future;
      await ref.read(layoutProvider(LayoutType.home).future);
      final endTime = DateTime.now();
      final difference = endTime.difference(startTime).inMilliseconds;
      if (difference < 2000) {
        await Future.delayed(Duration(milliseconds: 2000 - difference));
      }
      final apiVersion = _getApiVersion();
      if (apiVersion != null && await _isNeedToUpdate(apiVersion)) {
        return AppInitialResult.goUpdate;
      }
      return AppInitialResult.goHome;
    } else {
      return AppInitialResult.goLocationSelector;
    }
  }

  String? _getApiVersion() {
    final appData = ref.read(appDataControllerProvider).asData?.value;
    final apiVersion = Platform.isAndroid
        ? appData?.androidApiVersion
        : appData?.iosApiVersion;
    return apiVersion;
  }

  Future<bool> _isNeedToUpdate(String apiVersion) async {
    final appVersion = ref.read(packageInfoProvider).requireValue.version;

    if (kDebugMode) {
      print('apiVersion: $apiVersion');
      print('appVersion: $appVersion');
    }
    return _isApiVersionGreater(apiVersion, appVersion);
  }

  bool _isApiVersionGreater(String apiVersion, String appVersion) {
    // Split the strings by '.' and convert each part to int
    List<int> apiParts = apiVersion.split('.').map(int.parse).toList();
    List<int> appParts = appVersion.split('.').map(int.parse).toList();

    // Compare each part from left to right
    for (int i = 0; i < apiParts.length; i++) {
      // If the api part is greater than the app part, return true
      if (apiParts[i] > appParts[i]) {
        return true;
      }
      // If the api part is less than the app part, return false
      if (apiParts[i] < appParts[i]) {
        return false;
      }
      // If the parts are equal, continue to the next part
    }
    // If all parts are equal, return false
    return false;
  }

  Future<void> setDefaultAddress(WidgetRef ref, String geofenceId,
      String latitude, String longitude) async {
    ref
        .read(geofenceIdAndCoordinatesProvider.notifier)
        .setGeofenceIdAndCoordinates(geofenceId, latitude, longitude);
    await ref.read(appDataControllerProvider.notifier).future;
    state = const AsyncData(AppInitialResult.goHome);
  }

  void goHome() {
    state = const AsyncData(AppInitialResult.goHome);
  }
}

enum AppInitialResult { goHome, goLocationSelector, goUpdate }
