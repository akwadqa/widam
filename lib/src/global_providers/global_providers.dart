import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'global_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async => await SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
Future<bool> canVibrate(CanVibrateRef ref) async => await Vibrate.canVibrate;

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(PackageInfoRef ref) async => await PackageInfo.fromPlatform();

@riverpod
double topPadding(TopPaddingRef ref, BuildContext context) {
  return MediaQuery.paddingOf(context).top > 30 ? 40 : 30;
}
