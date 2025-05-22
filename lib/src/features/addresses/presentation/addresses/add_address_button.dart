import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:widam/src/common_widgets/app_adding_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../../utils/utils.dart';
import '../../domain/location/location.dart';
import '../maps/location_picker/location_picker.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAddingButton(
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
      title: S.of(context).addNewAddress,
    );
  }
}
