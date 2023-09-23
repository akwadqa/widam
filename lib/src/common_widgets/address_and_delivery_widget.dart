import 'package:flutter/material.dart';

import '../features/addresses/presentation/maps/address_selector_button/address_selector_button.dart';
import '../features/time_slots/presentation/app_time_slot.dart';

class AddressAndDeliveryWidget extends StatelessWidget {
  const AddressAndDeliveryWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [AddressSelector(), Spacer(), AppTimeSlot()],
    );
  }
}
