import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../theme/app_colors.dart';

enum Frequency {
  Daily,
  Weekly,
  Monthly,
  BiWeekly,
  BiMonthly;

  String get frequencyName {
    return switch (this) {
      Frequency.Daily => S.current.daily,
      Frequency.Weekly => S.current.weekly,
      Frequency.Monthly => S.current.monthly,
      Frequency.BiWeekly => S.current.biWeekly,
      Frequency.BiMonthly => S.current.biMonthly,
    };
  }
}

class FrequencySelectorFormField extends FormField<Frequency> {
  FrequencySelectorFormField({
    super.key,
    Frequency super.initialValue = Frequency.Daily,
    super.onSaved,
  }) : super(
          builder: (FormFieldState<Frequency> state) {
            return _FilterSelectionWidget(
              selectedFilter: state.value!,
              onFilterSelected: state.didChange,
            );
          },
        );
}

class _FilterSelectionWidget extends StatefulWidget {
  final Frequency selectedFilter;
  final ValueChanged<Frequency> onFilterSelected;

  const _FilterSelectionWidget({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  State<_FilterSelectionWidget> createState() => _FilterSelectionWidgetState();
}

class _FilterSelectionWidgetState extends State<_FilterSelectionWidget> {
  late Frequency _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.selectedFilter;
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 5,
      ),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: Frequency.values.map((filter) {
        final isSelected = _selectedFilter == filter;
        return FilterChip(
          label: SizedBox(
            width: double.infinity,
            child: Text(
              filter.frequencyName,
              textAlign: TextAlign.center,
            ),
          ),
          side: isSelected
              ? const BorderSide(color: AppColors.darkBlue, width: 1)
              : null,
          labelStyle: isSelected
              ? const TextStyle(
                  color: AppColors.darkBlue, fontWeight: FontWeight.w600)
              : null,
          selected: isSelected,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          onSelected: (value) {
            if (value) {
              setState(() {
                _selectedFilter = filter;
              });
              widget.onFilterSelected(filter);
            }
          },
        );
      }).toList(),
    );
  }
}
