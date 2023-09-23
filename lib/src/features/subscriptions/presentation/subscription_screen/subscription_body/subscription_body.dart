import 'package:flutter/material.dart';
import 'select_your_product/select_your_product.dart';
import 'set_your_schedule/set_your_schedule.dart';

import 'confirmation/confirmation.dart';

class SubscriptionBody extends StatelessWidget {
  const SubscriptionBody({Key? key, required this.stepIndex}) : super(key: key);
  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: stepIndex,
      children: const [
        SelectYourProduct(),
        SetYourSchedule(),
        Confirmation(),
      ],
    );
  }
}
