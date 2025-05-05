import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_theme.dart';

class LocationPermissionCheckerBanner extends StatelessWidget {
  const LocationPermissionCheckerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Geolocator.getServiceStatusStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == ServiceStatus.disabled) {
            return Column(
              children: [
                AppBanner(
                  leadingIcon: Assets.icons.warningIcon.svg(),
                  message: S.of(context).locationEnableMessage,
                  trailing: const _SettingsButton(),
                ),
                const SizedBox(height: 8),
              ],
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class _SettingsButton extends ConsumerWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return ElevatedButton(
        onPressed: () async {
          await Geolocator.openLocationSettings();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.red,
          textStyle:
              TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily),
        ),
        child: Text(S.of(context).settings));
  }
}
