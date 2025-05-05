import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart';
import '../add_address_button.dart';
import '../addresses_list/addresses_list.dart';

class AddressesSelector extends StatelessWidget {
  const AddressesSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).selectYourAddress,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 20.0),
              const AddAddressButton(),
              const SizedBox(height: 20.0),
              const AddressesList(isEditable: false),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}
