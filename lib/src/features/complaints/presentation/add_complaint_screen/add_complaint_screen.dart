import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/features/complaints/presentation/add_complaint_screen/complaint_type_drop_down.dart';

@RoutePage()
class AddComplaintScreen extends ConsumerStatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  ConsumerState<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends ConsumerState<AddComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  ComplaintType? _complaintType;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: Text(S.of(context).complaints),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            ComplaintTypeDropDown(
              onSaved: (value) => _complaintType = value,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: S.of(context).addComplaint,
                hintText: S.of(context).writeDiscription,
              ),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              validator: qValidator([IsRequired(S.of(context).required)]),
              onSaved: (value) => _description = value,
            ),
            const Spacer(),
            SubmitButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.popRoute();
                  }
                },
                text: S.of(context).submit),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }
}
