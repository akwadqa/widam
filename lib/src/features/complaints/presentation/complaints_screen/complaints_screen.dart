import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_adding_button.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/features/complaints/domain/complaint/complaint.dart';
import 'package:widam/src/features/complaints/presentation/complaints_list/complaints_controller.dart';
import 'package:widam/src/features/complaints/presentation/complaints_list/complaints_list.dart';
import 'package:widam/src/routing/app_router.gr.dart';

@RoutePage()
class ComplaintsScreen extends ConsumerWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: Text(S.of(context).complaints),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          SizedBox(height: 40.0),
          AddCompalintButton(),
          SizedBox(height: 30.0),
          Expanded(child: ComplaintsList()),
        ]),
      ),
    );
  }
}

class AddCompalintButton extends ConsumerWidget {
  const AddCompalintButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppAddingButton(
        onPressed: () {
          context.pushRoute(const AddComplaintScreen()).then((value) {
            if (value != null) {
              ref
                  .read(complaintsControllerProvider.notifier)
                  .addComplaint(value as Complaint);
            }
          });
        },
        title: S.of(context).addNewComplaint);
  }
}
