import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';

import '../../../../../../theme/app_colors.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../app_data/application/app_data_controller.dart';
import '../../../../../time_slots/domain/geofence_details/time_slot.dart';
import '../../../../../time_slots/presentation/time_slots_selector/time_slots_selector.dart';

class TimeSlotsFormField extends FormField<TimeSlot> {
  TimeSlotsFormField(
      {super.key,
      required BuildContext context,
      required TimeSlot? initialTimeSlot,
      super.onSaved,
      super.validator})
      : super(
          initialValue: initialTimeSlot,
          builder: (FormFieldState<TimeSlot> state) {
            return Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                      border: Border.all(
                        color: AppColors.lapisBlue,
                        width: 0.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(state.value!.timeFormatted),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        Assets.icons.truckTimeIcon.svg(),
                      ],
                    ),
                  ),
                  onTap: () async {
                    final appData =
                        ref.read(appDataControllerProvider).asData?.value;
                    final ({TimeSlot timeSlot, String deliveryDate})? value =
                        await showAdaptiveModalBottomSheet<
                            ({TimeSlot timeSlot, String deliveryDate})?>(
                      context: context,
                      builder: (context) => TimeSlotsSelector(
                        deleiveryMethodId: 'Normal Delivery',
                        initialDate: appData!.deliveryDate.date,
                        initialTimeSlot: appData.timeSlot,
                      ),
                    );
                    if (value != null) {
                      state.didChange(value.timeSlot);
                    }
                  },
                );
              },
            );
          },
        );

  @override
  FormFieldState<TimeSlot> createState() => _TimeSlotsFormFieldState();
}

class _TimeSlotsFormFieldState extends FormFieldState<TimeSlot> {}
