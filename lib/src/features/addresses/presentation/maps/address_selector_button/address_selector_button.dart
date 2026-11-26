import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../utils/utils.dart';
import '../location_picker/location_picker.dart';
import '../../../../auth/application/user_data_provider.dart';
import '../../../domain/address/address.dart';
import '../../../domain/location/location.dart';
import '../../addresses/addresses_selector/addresses_selector.dart';
import '../../../../../../gen/assets.gen.dart';
import 'address_selector_button_controller.dart';

/// Opens the saved addresses sheet for signed-in users, or the map location
/// picker for guests, and saves the choice through
/// [AddressSelectorButtonController].
void showAddressSelector(BuildContext context, WidgetRef ref) {
  if (ref.read(userDataProvider) != null) {
    showAdaptiveModalBottomSheet<Address?>(
      context: context,
      builder: (context) => const AddressesSelector(),
    ).then((address) async {
      if (address != null) {
        await ref
            .read(addressSelectorButtonControllerProvider.notifier)
            .onAddressSelected(address);
      }
    });
    return;
  }
  showAdaptiveModalBottomSheet<Location?>(
          context: context,
          enableDrag: false,
          builder: (context) => const LocationPicker())
      .then((Location? location) {
    final geofence = location?.matchedGeofence;
    final latitude = location?.latitude;
    final longitude = location?.longitude;
    if (geofence == null || latitude == null || longitude == null) return;
    ref
        .read(addressSelectorButtonControllerProvider.notifier)
        .onCoordinatesSelected(geofence, latitude, longitude,
            location?.defaultAddress?.deliveryCenter.warehouseId);
  });
}

class AddressSelector extends ConsumerWidget {
  const AddressSelector({super.key, this.foregroundColor = Colors.black});
  final Color foregroundColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return TextButton.icon(
        onPressed: () => showAddressSelector(context, ref),
        icon: Assets.icons.locationIcon.svg(
            colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn)),
        label: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddressText(),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: foregroundColor,
          maximumSize: const Size.fromWidth(135),
          textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
        ));
  }
}

class AddressText extends ConsumerWidget {
  const AddressText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressName = ref.watch(addressSelectorButtonControllerProvider);
    return Text(addressName.asData?.value ?? '');
  }
}
