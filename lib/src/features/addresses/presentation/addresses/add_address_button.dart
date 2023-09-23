import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../../domain/location/location.dart';
import '../maps/location_picker/location_picker.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showAdaptiveModalBottomSheet<Location?>(
                context: context,
                enableDrag: false,
                builder: (context) => const LocationPicker())
            .then((Location? location) {
          if (location != null) {
            context.pushRoute(AddEditAddressScreen(
                latitude: location.latitude!,
                longitude: location.longitude!,
                geofenceId: location.matchedGeofence!.geofenceId));
          }
        });
      },
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 43),
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.gray, width: 0.5),
          foregroundColor: AppColors.londonRain),
      child: Text('+ ${S.of(context).addNewAddress}'),
    );
  }
}
