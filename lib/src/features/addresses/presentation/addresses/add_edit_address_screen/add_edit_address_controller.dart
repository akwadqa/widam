import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/addresses_repository.dart';
import '../../../domain/address/address.dart';

import '../addresses_list/addresses_list_controller.dart';

part 'add_edit_address_controller.g.dart';

@riverpod
class AddEditAddressController extends _$AddEditAddressController {
  @override
  FutureOr<Address?> build() => null;

  Future<void> addAddress(Address address) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.watch(addressesRepositoryProvider).addAddress(address));
    if (state is AsyncData) {
      ref
          .read(addressesListControllerProvider.notifier)
          .addAddress(state.asData!.value!);
    }
  }

  Future<void> updateAddress(Address address) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.watch(addressesRepositoryProvider).updateAddress(address));
    if (state is AsyncData) {
      ref.read(addressesListControllerProvider.notifier).updateAddress(address);
    }
  }
}
