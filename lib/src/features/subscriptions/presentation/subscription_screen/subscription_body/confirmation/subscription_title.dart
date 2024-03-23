import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_info/subscription_title_controller.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../theme/app_colors.dart';

class SubscriptionTitle extends ConsumerWidget {
  const SubscriptionTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 20, end: 35),
          child: _TextWidget(),
        ),
        PositionedDirectional(
          end: 0,
          top: 0,
          child: IconButton(
            icon: Assets.icons.editIcon.svg(),
            onPressed: () => _showEditDialog(context, ref),
          ),
        ),
      ],
    );
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref) async {
    final formKey = GlobalKey<FormState>();
    String? title;
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            title: Text(S.of(context).editTitle),
            content: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: S.of(context).enterAnewTitle,
              ),
              validator: qValidator([IsRequired(S.of(context).required)]),
              onSaved: (value) => title = value,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: context.maybePop,
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.maybePop(title);
                    }
                  },
                  child: Text(S.of(context).save)),
            ],
          ),
        );
      },
    );

    if (result != null) {
      ref
          .read(subscriptionTitleControllerProvider.notifier)
          .setSubscriptionTitle(result);
    }
  }
}

class _TextWidget extends ConsumerWidget {
  const _TextWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(subscriptionTitleControllerProvider),
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.midnightBlue,
          fontSize: 18),
    );
  }
}
