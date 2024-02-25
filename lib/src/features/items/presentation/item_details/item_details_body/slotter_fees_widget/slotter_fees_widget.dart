import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_filter_chip.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/slotter_fees_widget/slotter_fees_controller.dart';
import 'package:widam/src/features/items/presentation/item_details/option_label.dart';

class SlotterFeesWidget extends ConsumerWidget {
  final ItemDetails itemDetails;

  const SlotterFeesWidget({
    super.key,
    required this.itemDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppFilterChip(
        isSelected: ref.watch(slotterFeesControllerProvider),
        onSelected: (value) => ref
            .read(slotterFeesControllerProvider.notifier)
            .setIsCheckedSoltterFees(value),
        lable:
            '${itemDetails.priceModifierTitle} ${itemDetails.priceModifier} (${S.of(context).optional})');
  }
}
