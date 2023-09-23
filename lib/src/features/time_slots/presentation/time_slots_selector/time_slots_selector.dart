import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:widam/main.dart';
import 'package:widam/src/features/time_slots/domain/geofence_details/time_slot.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../common_widgets/submit_button.dart';
import '../../data/time_slots_repository.dart';
import '../../../../theme/app_colors.dart';

import '../../domain/geofence_details/date.dart';

class TimeSlotsSelector extends StatelessWidget {
  const TimeSlotsSelector(
      {super.key,
      required this.deleiveryType,
      required this.initialDate,
      required this.initialTimeSlot});
  final String deleiveryType;
  final String initialDate;
  final TimeSlot initialTimeSlot;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).selectYourDeliverySlot,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 25),
            _DatesList(
                deleviryType: deleiveryType,
                initialDate: initialDate,
                initialTimeSlot: initialTimeSlot),
          ],
        ),
      ),
    );
  }
}

class _DatesList extends ConsumerWidget {
  const _DatesList(
      {required this.deleviryType,
      required this.initialDate,
      required this.initialTimeSlot});
  final String deleviryType;
  final String initialDate;
  final TimeSlot initialTimeSlot;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geofenceDetailsAsync = ref.watch(geofenceDetailsProvider);
    return geofenceDetailsAsync.when(
      data: (geofenceDetails) {
        final deliveryMethod = geofenceDetails.deliveryMethods.first;
        final List<Date> dates = deliveryMethod.timeSlotGroup.dates;
        return dates.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(40),
                child: Text(S.of(context).noDatesAvailable),
              )
            : _Body(
                dates: dates,
                initialDate: initialDate,
                initialTimeSlot: initialTimeSlot,
                deliveryCharges: deliveryMethod.deliveryCharges.toString(),
              );
      },
      error: (error, stack) =>
          AppBanner(message: error.toString(), stackTrace: stack),
      loading: () => const FadeCircleLoadingIndicator(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(
      {required this.dates,
      required this.initialDate,
      required this.initialTimeSlot,
      required this.deliveryCharges});
  final List<Date> dates;
  final String initialDate;
  final TimeSlot initialTimeSlot;
  final String deliveryCharges;

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late String _selectedDate;
  late TimeSlot _selectedTimeSlot;

  @override
  void initState() {
    _selectedDate = widget.initialDate;
    _selectedTimeSlot = widget.initialTimeSlot;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDates =
        widget.dates.where((element) => element.date == _selectedDate);
    final List<TimeSlot> timeSlots =
        selectedDates.toList().isNotEmpty ? selectedDates.first.timeSlots : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 65,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.dates.length,
            itemBuilder: (context, index) {
              final date = widget.dates[index];
              return FilterChip(
                label: Column(
                  children: [
                    Text(date.dateFormatted.split(',').last,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(date.dateFormatted.split(',').first,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                labelStyle: TextStyle(
                    color: _selectedDate == date.date ? Colors.white : null),
                selected: _selectedDate == date.date,
                onSelected: date.timeSlots.isEmpty
                    ? null
                    : (value) {
                        setState(() {
                          _selectedDate = date.date;
                        });
                      },
                selectedColor: AppColors.londonRain,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 5),
          ),
        ),
        const SizedBox(height: 20),
        Text(S.of(context).chooseYourTimeSlot,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 10),
        GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 7 / 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 80),
          itemCount: timeSlots.length,
          itemBuilder: (context, index) {
            return Consumer(
              builder: (context, ref, child) {
                return FilterChip(
                  label: SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      const SizedBox(height: 8),
                      Text(timeSlots[index].timeFormatted,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _selectedTimeSlot.timeSlotId ==
                                      timeSlots[index].timeSlotId
                                  ? AppColors.darkBlue
                                  : null)),
                      const SizedBox(height: 8.0),
                      Text(
                          timeSlots[index].timeslotOverload == 1
                              ? S.of(context).fullyBooked
                              : '${S.of(context).deliveryFees} ${widget.deliveryCharges}',
                          style: TextStyle(
                              color: _selectedTimeSlot.timeSlotId ==
                                      timeSlots[index].timeSlotId
                                  ? AppColors.darkBlue
                                  : null))
                    ]),
                  ),
                  side: _selectedTimeSlot.timeSlotId ==
                          timeSlots[index].timeSlotId
                      ? const BorderSide(color: AppColors.darkBlue, width: 1)
                      : null,
                  selected: _selectedTimeSlot.timeSlotId ==
                      timeSlots[index].timeSlotId,
                  onSelected: timeSlots[index].timeslotOverload == 1
                      ? null
                      : (value) {
                          if (value) {
                            if (ref.read(canVibrateProvider)) {
                              Vibrate.feedback(FeedbackType.light);
                            }
                            setState(() {
                              _selectedTimeSlot = timeSlots[index];
                            });
                          }
                        },
                );
              },
            );
          },
          shrinkWrap: true,
        ),
        const SizedBox(height: 40),
        SubmitButton(
            text: S.of(context).select,
            onPressed: () {
              if (_selectedTimeSlot.timeSlotId !=
                  widget.initialTimeSlot.timeSlotId) {
                context.popRoute<({TimeSlot timeSlot, String deliveryDate})?>(
                    (timeSlot: _selectedTimeSlot, deliveryDate: _selectedDate));
              } else {
                context.popRoute();
              }
            }),
        SizedBox(height: 20 + getBottomPadding(context))
      ],
    );
  }
}
