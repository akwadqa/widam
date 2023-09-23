import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../theme/app_colors.dart';

part 'address_labels.g.dart';

@riverpod
List<({String title, String value})> addressLabels(AddressLabelsRef ref) => [
      (title: S.current.villa, value: 'Permanent'),
      (title: S.current.office, value: 'Office'),
      (title: S.current.apartment, value: 'Shipping'),
    ];

@riverpod
List<SvgGenImage> icons(IconsRef ref) => [
      Assets.icons.villaIcon,
      Assets.icons.officeIcon,
      Assets.icons.apartmentIcon,
    ];

class AddressLabels extends FormField<({String title, String value})> {
  AddressLabels({
    super.key,
    ({String title, String value})? initialValue,
    FormFieldSetter<({String title, String value})>? onSaved,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            builder: (state) {
              return Consumer(builder: (context, ref, child) {
                final labels = ref.watch(addressLabelsProvider);
                final icons = ref.watch(iconsProvider);
                return Wrap(
                    spacing: 8.0,
                    children: labels
                        .map((label) => FilterChip(
                            label: Text(label.title),
                            labelStyle: TextStyle(
                                color: state.value == label
                                    ? AppColors.darkBlue
                                    : null),
                            avatar: icons[labels.indexOf(label)].svg(
                                color: state.value == label
                                    ? AppColors.darkBlue
                                    : null),
                            side: state.value == label
                                ? const BorderSide(
                                    color: AppColors.darkBlue, width: 1.0)
                                : null,
                            onSelected: (value) {
                              if (value) state.didChange(label);
                            },
                            selected: state.value == label))
                        .toList());
              });
            });
}
