import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/address.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';

part 'subscription_address_controller.g.dart';

@Riverpod(keepAlive: true)
class SubscriptionAddressController extends _$SubscriptionAddressController {
  @override
  Address build() {
    return ref.watch(appDataControllerProvider).asData!.value.address!;
  }

  void changeAddress(Address address) {
    state = address;
  }
}
