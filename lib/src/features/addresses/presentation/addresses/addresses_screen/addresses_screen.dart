import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart';
import '../adaptive_back_button.dart';
import '../addresses_list/addresses_list.dart';

import '../add_address_button.dart';

@RoutePage()
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: Text(S.of(context).yourAddresses),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          SizedBox(height: 40.0),
          AddAddressButton(),
          SizedBox(height: 20.0),
          Expanded(child: AddressesList()),
        ]),
      ),
    );
  }
}
