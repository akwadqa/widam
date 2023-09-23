import 'package:geocoding/geocoding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/geofence.dart';
import '../../../../../localization/current_language.dart';
import '../../../application/geofence_id_controller.dart';

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
          ref.watch(geofenceIdAndCoordinatesProvider).coordinates.latitude;
      final longitude =
          ref.watch(geofenceIdAndCoordinatesProvider).coordinates.longitude;
      final String placeName = await _getPlaceName(latitude!, longitude!);
      return placeName;
    }
  }

  Future<String> _getPlaceName(String latitude, String longitude) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude),
        localeIdentifier: ref.read(currentLanguageProvider));
    final String address = placemarks.first.locality ?? '';
    return address;
  }

  void onAddressSelected(Address address) {
    ref.read(appDataControllerProvider.notifier).updateAddress(address);
    state = AsyncData(address.addressTitle);
  }

  Future<void> onCoordinatesSelected(
      Geofence geofence, String latitude, String longitude) async {
    ref
        .read(geofenceIdAndCoordinatesProvider.notifier)
        .setGeofenceIdAndCoordinates(geofence.geofenceId, latitude, longitude);
    ref.read(appDataControllerProvider.notifier).updateGeofence(geofence);
    final String placeName = await _getPlaceName(latitude, longitude);
    state = AsyncData(placeName);
  }
}
