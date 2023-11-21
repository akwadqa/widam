import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';
import 'package:widam/src/features/app_data/presentation/app_initial_screen/app_initial_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class UpdateScreen extends ConsumerWidget {
  const UpdateScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDataAsync = ref.watch(appDataControllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: appDataAsync.when(
            data: (appData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.widamLogo.svg(),
                  const SizedBox(height: 30),
                  Text(S.of(context).timeToUpdate,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  const SizedBox(height: 20),
                  Text(
                      '${S.of(context).newVersion}: ${Platform.isAndroid ? appData.androidApiVersion : appData.iosApiVersion}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    child: Text(appData.appUpdateMessage,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        final packageInfo =
                            ref.watch(packageInfoProvider).requireValue;
                        final packageName = packageInfo.packageName;
                        StoreRedirect.redirect(
                            androidAppId: packageName,
                            iOSAppId: Strings.iOSAppId);
                      },
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(
                              Size(double.infinity, 50))),
                      child: Text(S.of(context).update)),
                  if (!(appData.mandatoryToUpdate == 1))
                    TextButton(
                        onPressed: ref
                            .read(appInitialControllerProvider.notifier)
                            .goHome,
                        child: Text(S.of(context).notNow))
                ],
              );
            },
            error: (error, stackTrace) => Center(
                child: AppBanner(
                    message: error.toString(), stackTrace: stackTrace)),
            loading: () => const FadeCircleLoadingIndicator()),
      ),
    );
  }
}
