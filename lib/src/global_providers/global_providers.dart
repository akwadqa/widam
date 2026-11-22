import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'global_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async =>
    await SharedPreferences.getInstance();

@Riverpod(keepAlive: true)
Future<bool> canVibrate(Ref ref) async => await Vibrate.canVibrate;

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async =>
    await PackageInfo.fromPlatform();

@riverpod
double topPadding(Ref ref, double mediaQueryTopPadding) {
  return mediaQueryTopPadding > 30 ? 40 : 30;
}
