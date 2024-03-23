
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/features/complaints/presentation/add_complaint_screen/complaint_type_drop_down.dart';
import 'package:widam/src/features/complaints/presentation/add_complaint_screen/send_complaint_controller.dart';

@RoutePage()
class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
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
            Consumer(
              builder: (context, ref, child) {
                ref.listen(sendComplaintControllerProvider, (previous, next) {
                  if (next is AsyncData) {
                    context.maybePop(next.value);
                  } else if (next is AsyncError) {
                    showAppBannerDialog(
                        context, next.error.toString(), next.stackTrace);
                  }
                });
                final state = ref.watch(sendComplaintControllerProvider);
                if (state is AsyncLoading) {
                  return const FadeCircleLoadingIndicator();
                }
                return SubmitButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ref
                            .read(sendComplaintControllerProvider.notifier)
                            .sendComplaint(
                              complaintType: _complaintType!.name,
                              subject: _complaintType!.localize,
                              description: _description!,
                            );
                      }
                    },
                    text: S.of(context).submit);
              },
            ),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }
}
