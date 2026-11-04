import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_drop_down_bottom_sheet.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/filters_drop_down/filters_controller.dart';
import 'package:widam/src/theme/app_colors.dart';
import 'package:widam/src/utils/utils.dart';

class FiltersDropdownButtonFormField extends ConsumerStatefulWidget {
  const FiltersDropdownButtonFormField(
      {super.key, this.height = 40, this.width});

  final double height;
  final double? width;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FiltersDropdownButtonFormFieldState();
}

class _FiltersDropdownButtonFormFieldState
    extends ConsumerState<FiltersDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filtersProvider);
    return SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.secondary,
              hintText: S.of(context).sortBy,
              border: _outlineInputBorder,
              enabledBorder: _outlineInputBorder,
              hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              suffixIcon: const Icon(Icons.arrow_drop_down),
              suffixIconColor: Colors.white),
          onTap: () {
            showAdaptiveModalBottomSheet(
                context: context,
                builder: (context) {
                  return AppDropDownBottomSheet<FilterType>(
               items: filters,
  onTap: (filter) {
    ref
        .read(selectedFilterControllerProvider.notifier)
        .set(filter);
  },
  title: (filter) {
    switch (filter) {
      case FilterType.priceHighToLow:
        return S.of(context).priceHighToLow;

      case FilterType.priceLowToHigh:
        return S.of(context).priceLowToHigh;

      case FilterType.nameAtoZ:
        return S.of(context).nameAtoZ;

      case FilterType.nameZtoA:
        return S.of(context).nameZtoA;
    }
  },
  // title: S.of(context).selectFilter,
                  );
                });
          },
        ));
  }

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      );
}
