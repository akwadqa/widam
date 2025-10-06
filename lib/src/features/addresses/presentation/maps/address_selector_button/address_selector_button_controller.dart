import 'package:geocoding/geocoding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/addresses/data/addresses_repository.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import '../../../domain/geofence.dart';
import '../../../application/local_location_info.dart';

import '../../../../app_data/application/app_data_controller.dart';
import '../../../domain/address/address.dart';

part 'address_selector_button_controller.g.dart';

@riverpod
class AddressSelectorButtonController
    extends _$AddressSelectorButtonController {
  @override
  FutureOr<String> build() {
    return _getAddressName();
  }

  Future<String> _getAddressName() async {
    final appData = ref.watch(appDataControllerProvider).asData?.value;
    if (appData?.address != null) {
      return appData!.address!.addressTitle;
    } else {
      final latitude =
          ref.watch(localLocationInfoProvider).coordinates.latitude;
      final longitude =
          ref.watch(localLocationInfoProvider).coordinates.longitude;
      final String placeName = await _getPlaceName(latitude!, longitude!);
      return placeName;
    }
  }

  Future<String> _getPlaceName(String latitude, String longitude) async {
    await setLocaleIdentifier(ref.read(currentLanguageProvider));
    final List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    final String address = placemarks.first.locality ?? '';
    return address;
  }

  Future<void> onAddressSelected(Address address) async {
    await ref.read(addressesRepositoryProvider).selectAddress(address.addressId);

    await ref.read(appDataControllerProvider.notifier).updateAddress(address);
    state = AsyncData(address.addressTitle);
  }

  Future<void> onCoordinatesSelected(
      Geofence geofence, String latitude, String longitude,
      [String? warehouseId]) async {
    ref
        .read(localLocationInfoProvider.notifier)
        .setLocalLocationInfo(latitude, longitude, warehouseId);
    ref
        .read(localGeofenceIdProvider.notifier)
        .setLocalGeofenceId(geofence.geofenceId);
    ref.read(appDataControllerProvider.notifier).updateGeofence(geofence);
    final String placeName = await _getPlaceName(latitude, longitude);
    state = AsyncData(placeName);
  }
}
