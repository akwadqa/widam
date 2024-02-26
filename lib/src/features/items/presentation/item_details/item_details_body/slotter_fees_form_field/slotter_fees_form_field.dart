import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_widgets/app_filter_chip.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/slotter_fees_form_field/slotter_fees_controller.dart';

part 'slotter_fees_form_field.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<FormState> slotterFeesFormKey(SlotterFeesFormKeyRef ref) =>
    GlobalKey<FormState>();

class SlotterFeesFormField extends FormField<bool> {
  final ItemDetails itemDetails;

  SlotterFeesFormField({
    super.key,
    required this.itemDetails,
    super.validator,
    bool super.initialValue = false,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return Consumer(
              builder: (context, ref, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppFilterChip(
                        isSelected: ref.watch(slotterFeesControllerProvider),
                        onSelected: (value) {
                          ref
                              .read(slotterFeesControllerProvider.notifier)
                              .setIsCheckedSoltterFees(value);
                          state.didChange(value);
                        },
                        lable:
                            '${itemDetails.priceModifierTitle} ${itemDetails.priceModifier}'),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                );
              },
            );
          },
        );
}
