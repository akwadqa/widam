import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../../common_widgets/submit_button.dart';
import '../../../../../utils/utils.dart';
import '../validate_coordinates_banner/validate_coordinates_notifier.dart';

class ConfirmLocationButton extends ConsumerWidget {
  const ConfirmLocationButton({super.key, required this.markers});

  final List<Marker> markers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(validateCoordinatesProvider, (previous, next) {
      if (next is ValidateCoordinatesError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      }
      if (next is ValidateCoordinatesLoaded) {
        if (!isInvalidLocation(next, markers)) {
          context.popRoute(next.location);
        }
      }
    });
    final state = ref.watch(validateCoordinatesProvider);
    final currentPosition = markers.isNotEmpty ? markers.first.position : null;
    if (state is ValidateCoordinatesLoading &&
        state.loadingType == LoadingType.confirm) {
      return const FadeCircleLoadingIndicator();
    }
    return SubmitButton(
      onPressed: isInvalidLocation(state, markers) || markers.isEmpty
          ? null
          : () => ref
              .read(validateCoordinatesProvider.notifier)
              .validateCoordinates(
                  latitude: currentPosition!.latitude,
                  longitude: currentPosition.longitude,
                  loadingType: LoadingType.confirm),
      text: S.of(context).confirmLocation,
    );
  }
}
