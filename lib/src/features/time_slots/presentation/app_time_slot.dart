import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'time_slot_controller.dart';
import 'time_slot_label.dart';

class AppTimeSlot extends ConsumerWidget {
  const AppTimeSlot(
      {super.key, this.onTap, this.foregroundColor = Colors.black});
  final VoidCallback? onTap;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(timeSlotControllerProvider);
    return TimeSlotLabel(
        foregroundColor: foregroundColor,
        formattedDate: data.formattedDate,
        formattedTime: data.formattedTime,
        onTap: onTap);
  }
}
