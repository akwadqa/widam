import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../utils/utils.dart';

import '../../../../../../../gen/assets.gen.dart';

enum DateType { start, end }

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField(
      {super.key, this.onSaved, this.dateType = DateType.start});

  final FormFieldSetter<String>? onSaved;
  final DateType dateType;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  final TextEditingController _controller = TextEditingController();
  late DateTime _initialDate;

  @override
  void initState() {
    _initialDate = widget.dateType == DateType.start
        ? DateTime.now()
        : DateTime.now().add(const Duration(days: 7));
    _controller.text = _initialDate.toFormattedString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onSaved: widget.onSaved,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () async {
            if (Platform.isIOS) {
              DatePicker.showDatePicker(
                context,
                locale: Directionality.of(context) == TextDirection.ltr
                    ? DateTimePickerLocale.en_us
                    : DateTimePickerLocale.ar,
                initialDateTime: _initialDate,
                minDateTime: _initialDate,
                maxDateTime: _lastDate(),
                onConfirm: (dateTime, selectedIndex) =>
                    _controller.text = dateTime.toFormattedString(),
              );
            } else {
              final DateTime? date = await showDatePicker(
                context: context,
                initialDate: _initialDate,
                firstDate: _initialDate,
                lastDate: _lastDate(),
              );
              if (date != null) {
                _controller.text = date.toFormattedString();
              }
            }
          },
          icon: Assets.icons.dateTimeIcon.svg(),
        ),
        border: _border,
        enabledBorder: _border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(width: 0.5),
        ),
      ),
    );
  }

  DateTime _lastDate() {
    return widget.dateType == DateType.start
        ? DateTime(DateTime.now().year + 5)
        : DateTime(DateTime.now().year + 10);
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(color: AppColors.gainsboro, width: 0.5),
      );
}
