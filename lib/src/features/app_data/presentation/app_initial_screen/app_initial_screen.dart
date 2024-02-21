import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/app_data/presentation/splash_screen/splash_screen.dart';
import 'package:widam/src/features/layouts/domain/block.dart';
import '../../../../utils/utils.dart';
import '../../../layouts/domain/banner/banner.dart';
import '../update_screen/update_screen.dart';
import 'app_initial_controller.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../addresses/domain/location/location.dart';
import '../../../addresses/presentation/maps/location_picker/location_picker.dart';

@RoutePage()
class AppInitialScreen extends ConsumerWidget {
  const AppInitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appInitialControllerProvider, (previous, next) {
      if (next.asData != null) {
        if (next.asData!.value is GoHome) {
          context.replaceRoute(HomeScreen());
        } else if (next.asData!.value is GoHomeWithMubadraBanner) {
          final Block<List<Banner>> bannerBlock =
              (next.asData!.value as GoHomeWithMubadraBanner).bannerBlock
                  as Block<List<Banner>>;
          context.replaceRoute(HomeScreen(bannerBlock: bannerBlock));
        } else if (next.asData!.value is GoLocationSelector) {
          showAdaptiveModalBottomSheet<Location?>(
                  context: context,
                  builder: (context) =>
                      const LocationPicker(withDefaultLocation: true),
                  enableDrag: false,
                  isDismissible: false)
              .then((Location? location) {
            if (location != null) {
              ref.read(appInitialControllerProvider.notifier).setDefaultAddress(
                  ref,
                  location.defaultAddress.geofence.geofenceId,
                  location.defaultAddress.latitude,
                  location.defaultAddress.longitude);
            }
          });
        }
      }
    });
    final state = ref.watch(appInitialControllerProvider);
    if (ref.watch(appInitialControllerProvider) is AsyncData &&
        state.asData!.value is GoUpdate) {
      return const UpdateScreen();
    }
    return const SplashScreen();
  }
}
