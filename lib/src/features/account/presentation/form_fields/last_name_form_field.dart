import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/src/utils/utils.dart';

import '../../../../../generated/l10n.dart';

class LastNameFormField extends StatelessWidget {
  const LastNameFormField({super.key, this.onSaved, this.initialValue});
  final FormFieldSetter<String>? onSaved;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: S.of(context).lastName,
        hintText: S.of(context).lastNameHint,
      ),
      inputFormatters: [UserNameInputFormatter()],
      validator: qValidator([IsRequired(S.of(context).required)]),
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      onSaved: onSaved,
    );
  }
}
