import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class TitleRadiosFormField extends FormField<String> {
  TitleRadiosFormField(
      {Key? key,
      void Function(String?)? onSaved,
      String? initialValue,
      required BuildContext context})
      : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (FormFieldState<String> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black)),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(
                      3,
                      (index) => _RadioButton(
                            value: index == 0
                                ? 'Mr'
                                : index == 1
                                    ? 'Mrs'
                                    : 'Miss/Ms',
                            groupValue: field.value!,
                            onChanged: (value) => field.didChange(value),
                            label: index == 0
                                ? S.current.mr
                                : index == 1
                                    ? S.current.mrs
                                    : S.current.missOrMs,
                            isSelect: field.value ==
                                (index == 0
                                    ? 'Mr'
                                    : index == 1
                                        ? 'Mrs'
                                        : 'Miss/Ms'),
                          )),
                ),
              ],
            );
          },
        );
}

class _RadioButton extends StatelessWidget {
  const _RadioButton(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.label,
      required this.isSelect})
      : super(key: key);

  final String value;
  final String groupValue;
  final void Function(String?) onChanged;
  final String label;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelect ? Colors.black : AppColors.spanishGray,
                fontSize: 13)),
      ],
    );
  }
}
