import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'global_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
bool canVibrate(CanVibrateRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
PackageInfo packageInfo(PackageInfoRef ref) => throw UnimplementedError();

@riverpod
double topPadding(TopPaddingRef ref, BuildContext context) {
  return MediaQuery.paddingOf(context).top > 30 ? 40 : 30;
}
