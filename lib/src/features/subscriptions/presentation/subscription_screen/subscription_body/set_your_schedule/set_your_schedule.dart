import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_address_controller.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/time_slot_form_field.dart';
import 'package:widam/src/features/time_slots/domain/geofence_details/time_slot.dart';
import '../../../../../../common_widgets/change_button.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../addresses/domain/address/address.dart';
import '../../../../../addresses/presentation/addresses/address_card.dart';
import '../../../../../addresses/presentation/addresses/addresses_selector/addresses_selector.dart';
import '../../../../../app_data/application/app_data_controller.dart';
import '../block_title.dart';
import 'frequency_selector_form_field.dart';
import '../../subscription_screen.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../common_widgets/submit_button.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../domain/subscription.dart';
import '../select_your_product/subscribe_button.dart';
import 'date_picker_form_field.dart';

final subscriptionInfoProvider = StateProvider.autoDispose((ref) {
  final items = ref.watch(selectedSubscriptionItemsProvider);
  return Subscription(
    title: '',
    startDate: '',
    endDate: '',
    interval: Frequency.Daily,
    intervalCount: 1,
    timeSlotId: '',
    addressId: '',
    items: items,
  );
});

class SetYourSchedule extends ConsumerStatefulWidget {
  const SetYourSchedule({super.key});

  @override
  ConsumerState<SetYourSchedule> createState() => _SetYourScheduleState();
}

class _SetYourScheduleState extends ConsumerState<SetYourSchedule> {
  final _formKey = GlobalKey<FormState>();

  Frequency? _frequency;
  String? _startDate;
  String? _endDate;
  TimeSlot? _timeSlot;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(S.of(context).chooseYourSchedule,
                          style: const TextStyle(
                              color: AppColors.raisinBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(S.of(context).chooseYourScheduleDescription,
                          style: const TextStyle(
                              color: AppColors.raisinBlack,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                      FrequencySelectorFormField(
                        onSaved: (value) => _frequency = value,
                      ),
                      const SizedBox(height: 25),
                      BlockTitle(title: S.of(context).subscriptionStartsOn),
                      const SizedBox(height: 5),
                      DatePickerFormField(
                        onSaved: (value) => _startDate = value,
                      ),
                      const SizedBox(height: 25),
                      BlockTitle(title: S.of(context).subscriptionEndsOn),
                      const SizedBox(height: 5),
                      DatePickerFormField(
                        dateType: DateType.end,
                        onSaved: (value) => _endDate = value,
                      ),
                      const SizedBox(height: 25),
                      BlockTitle(title: S.of(context).timeSlot),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (context, ref, child) {
                          return TimeSlotsFormField(
                            context: context,
                            initialTimeSlot: ref
                                .watch(appDataControllerProvider)
                                .asData
                                ?.value
                                .timeSlot,
                            onSaved: (timeSlot) => _timeSlot = timeSlot,
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlockTitle(
                              title: S.of(context).deliveryAddress,
                              icon: Assets.icons.addressIcon.svg()),
                          ChangeButton(
                            onPressed: () {
                              showAdaptiveModalBottomSheet<Address?>(
                                      context: context,
                                      builder: (ctx) =>
                                          const AddressesSelector())
                                  .then((address) {
                                if (address != null) {
                                  ref
                                      .read(
                                          subscriptionAddressControllerProvider
                                              .notifier)
                                      .changeAddress(address);
                                }
                              });
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (context, ref, child) {
                          final address =
                              ref.watch(subscriptionAddressControllerProvider);
                          return AddressCard(address: address);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return SubmitButton(
                  text: S.of(context).proceed,
                  onPressed: () {
                    _formKey.currentState!.save();
                    ref.read(subscriptionInfoProvider.notifier).update(
                        (state) => state.copyWith(
                            startDate: _startDate!,
                            endDate: _endDate!,
                            interval: _frequency!,
                            timeSlotId: _timeSlot!.timeSlotId,
                            intervalCount: _frequency == Frequency.BiMonthly ||
                                    _frequency == Frequency.BiWeekly
                                ? 2
                                : 1,
                            addressId: ref
                                .read(subscriptionAddressControllerProvider)
                                .addressId));
                    ref.read(stepIndexProvider.notifier).state = 2;
                  });
            }),
            SizedBox(height: 20 + getBottomPadding(context)),
          ],
        ),
      ),
    );
  }
}
