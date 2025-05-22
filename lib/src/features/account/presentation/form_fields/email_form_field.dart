import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';

import '../../../../../generated/l10n.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({super.key, this.onSaved, this.initialValue});
  final FormFieldSetter<String>? onSaved;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: S.of(context).email,
        hintText: S.of(context).emailHint,
      ),
      validator:
          qValidator([IsOptional(), IsEmail(S.of(context).invalidEmail)]),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onSaved: onSaved,
    );
  }
}
