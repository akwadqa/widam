import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';

import '../checkout_body/checkout_body.dart';

@RoutePage()
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).checkout),
      ),
      body: const CheckoutBody(),
    );
  }
}
