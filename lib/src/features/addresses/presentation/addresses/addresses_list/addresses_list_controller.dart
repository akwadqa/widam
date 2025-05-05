import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../application/local_location_info.dart';

import '../../../data/addresses_repository.dart';
import '../../../domain/address/address.dart';

part 'addresses_list_controller.g.dart';

@riverpod
class AddressesListController extends _$AddressesListController {
  @override
  FutureOr<List<Address>> build() {
    return ref.watch(addressesRepositoryProvider).getAddresses();
  }

  void addAddress(Address address) {
    state = AsyncData([...state.asData!.value, address]);
    _refreshAppLocationInfo(address);
  }

  void updateAddress(Address address) {
    state = AsyncData([
      for (final item in state.asData!.value)
        if (item.addressId == address.addressId) address else item
    ]);
    _refreshAppLocationInfo(address);
  }

  void deleteAddress(Address address) {
    final defaultAddress = state.asData!.value
        .firstWhere((element) => element.preferredShippingAddress == 1);
    _refreshAppLocationInfo(defaultAddress);
    state = AsyncData([
      for (final item in state.asData!.value)
        if (item.addressId != address.addressId) item
    ]);
  }

  void _refreshAppLocationInfo(Address address) {
    ref.read(localLocationInfoProvider.notifier).setLocalLocationInfo(
        address.latitude, address.longitude, address.warehouse?.warehouseId);
    ref
        .read(localGeofenceIdProvider.notifier)
        .setLocalGeofenceIdWithoutUpdateState(address.geofence!.geofenceId);
  }
}
