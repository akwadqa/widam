import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../common_widgets/banner/app_banner.dart';
import 'validate_coordinates_notifier.dart';

import '../../../../../utils/utils.dart';

class ValidateCoordinatesBanner extends ConsumerWidget {
  const ValidateCoordinatesBanner({super.key, required this.currentPosition});

  final LatLng currentPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(validateCoordinatesProvider);
    if (isInvalidLocation(state, currentPosition)) {
      return Column(
        children: [
          AppBanner(
              message: (state as ValidateCoordinatesLoaded).location.message!),
          const SizedBox(height: 8.0),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
