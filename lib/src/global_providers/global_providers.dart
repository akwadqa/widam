import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'global_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async =>
    await SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
Future<bool> canVibrate(CanVibrateRef ref) async => await Vibrate.canVibrate;

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(PackageInfoRef ref) async => await PackageInfo.fromPlatform();

@Riverpod(keepAlive: true)
Future<IosDeviceInfo> iosDeviceInfo(IosDeviceInfoRef ref) async {
  final deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.iosInfo;
}

@riverpod
bool? hasCentralizedNotch(HasCentralizedNotchRef ref) {
  if (Platform.isIOS) {
    final deviceModel = ref.watch(iosDeviceInfoProvider).requireValue.utsname.machine;
    return deviceModel.contains('15') || deviceModel.contains('16');
  }
  return null;
}