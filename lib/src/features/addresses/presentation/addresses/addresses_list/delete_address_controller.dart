import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/addresses_repository.dart';
import '../../../domain/address/address.dart';
import 'addresses_list_controller.dart';

part 'delete_address_controller.g.dart';

@riverpod
class DeleteAddressController extends _$DeleteAddressController {
  @override
  FutureOr<void> build() {}

  Future<bool> deleteAddress(Address address) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .watch(addressesRepositoryProvider)
        .deleteAddress(address.addressId));
    if (state is AsyncData) {
      ref.read(addressesListControllerProvider.notifier).deleteAddress(address);
      return true;
    }
    return false;
  }
}
