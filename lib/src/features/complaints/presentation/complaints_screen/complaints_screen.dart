import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_adding_button.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/routing/app_router.gr.dart';

@RoutePage()
class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          // SizedBox(height: 20.0),
          // Expanded(child: AddressesList()),
        ]),
      ),
    );
  }
}

class AddCompalintButton extends StatelessWidget {
  const AddCompalintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAddingButton(
        onPressed: () => context.pushRoute(const AddComplaintScreen()),
        title: S.of(context).addNewComplaint);
  }
}
