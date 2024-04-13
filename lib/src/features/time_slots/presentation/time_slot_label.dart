import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import 'time_slot_container.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class TimeSlotLabel extends StatelessWidget {
  const TimeSlotLabel(
      {super.key,
      required this.formattedDate,
      required this.formattedTime,
      this.foregroundColor = Colors.black,
      this.onTap});
  final String formattedDate;
  final String formattedTime;
  final VoidCallback? onTap;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TruckTimeIcon(foregroundColor),
        const SizedBox(width: 8),
        EarliestDeliveryText(
            isChangeable: onTap != null, foregroundColor: foregroundColor),
        const SizedBox(width: 8),
        TimeSlotContainer(
          formattedDate: formattedDate,
          formattedTime: formattedTime,
          onTap: onTap,
        )
      ],
    );
  }
}

class EarliestDeliveryText extends StatelessWidget {
  const EarliestDeliveryText({
    super.key,
    this.isChangeable = false,
    this.foregroundColor = Colors.black,
  });
  final bool isChangeable;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return Text(
        isChangeable
            ? S.of(context).changeTimeSlot
            : S.of(context).earliestDelivery,
        style: TextStyle(
            color: foregroundColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            height: 1));
  }
}

class TruckTimeIcon extends ConsumerWidget {
  const TruckTimeIcon(this.foregroundColor, {super.key});
  final Color foregroundColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(currentLanguageProvider);
    return Transform.flip(
        flipX: languageCode == 'ar',
        child: Assets.icons.truckTimeIcon.svg(
            colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn)));
  }
}
