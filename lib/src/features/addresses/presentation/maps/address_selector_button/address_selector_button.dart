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

class AddressSelector extends ConsumerWidget {
  const AddressSelector({Key? key, this.foregroundColor = Colors.black})
      : super(key: key);
  final Color foregroundColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return TextButton.icon(
        onPressed: () {
          if (ref.read(userDataProvider) != null) {
            showAdaptiveModalBottomSheet<Address?>(
              context: context,
              builder: (context) => const AddressesSelector(),
            ).then((address) {
              if (address != null) {
                ref
                    .read(addressSelectorButtonControllerProvider.notifier)
                    .onAddressSelected(address);
              }
            });
          } else {
            showAdaptiveModalBottomSheet<Location?>(
                    context: context,
                    enableDrag: false,
                    builder: (context) => const LocationPicker())
                .then((Location? location) {
              if (location != null) {
                ref
                    .read(addressSelectorButtonControllerProvider.notifier)
                    .onCoordinatesSelected(location.matchedGeofence!,
                        location.latitude!, location.longitude!);
              }
            });
          }
        },
        icon: Assets.icons.locationIcon.svg(color: foregroundColor),
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
              fontSize: 13.5,
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
