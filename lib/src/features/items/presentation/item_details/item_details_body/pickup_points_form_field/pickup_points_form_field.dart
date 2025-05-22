import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_widgets/app_filter_chip.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/pickup_points_form_field/selected_pickup_point_controller.dart';

part 'pickup_points_form_field.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<FormState> pickupPointsFormKey(PickupPointsFormKeyRef ref) =>
    GlobalKey<FormState>();

class PickupPointsFormField extends FormField<String?> {
  final ItemDetails itemDetails;

  PickupPointsFormField({
    super.key,
    required this.itemDetails,
    super.validator,
    super.initialValue,
  }) : super(
          builder: (FormFieldState<String?> state) {
            return PickupPointsFieldBuilder(
              itemDetails: itemDetails,
              state: state,
            );
          },
        );
}

class PickupPointsFieldBuilder extends ConsumerWidget {
  final ItemDetails itemDetails;
  final FormFieldState<String?> state;

  const PickupPointsFieldBuilder({
    super.key,
    required this.itemDetails,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final point = itemDetails.pickupPoints!.points[index];
              final isSelected =
                  ref.watch(selectedPickupPointControllerProvider) ==
                      point.pickupPointId;
              return AppFilterChip(
                isSelected: isSelected,
                onSelected: (value) =>
                    _onPickupPointSelected(value, ref, point.pickupPointId),
                lable: point.pickupPointName,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: itemDetails.pickupPoints!.points.length,
          ),
        ),
        if (state.hasError)
          Text(
            state.errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
      ],
    );
  }

  void _onPickupPointSelected(
      bool isSelected, WidgetRef ref, String pickupPointId) {
    if (isSelected) {
      ref
          .read(selectedPickupPointControllerProvider.notifier)
          .setPickupPoint(pickupPointId);
      state.didChange(pickupPointId);
    }
  }
}
