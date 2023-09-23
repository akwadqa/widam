import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import '../../../../../../localization/current_language.dart';

import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../theme/app_colors.dart';
import '../set_your_schedule/set_your_schedule.dart';

final subscriptionTitleProvider = StateProvider.autoDispose<String>((ref) {
  final interval = ref.watch(subscriptionInfoProvider).interval;
  if (ref.watch(currentLanguageProvider) == 'ar') {
    return 'اشتراك ${interval.frequencyName}';
  } else {
    return 'My ${interval.frequencyName} Subscription';
  }
});

class SubscriptionTitle extends ConsumerWidget {
  const SubscriptionTitle({Key? key}) : super(key: key);

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
                onPressed: context.popRoute,
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.popRoute(title);
                    }
                  },
                  child: Text(S.of(context).save)),
            ],
          ),
        );
      },
    );

    if (result != null) {
      ref.read(subscriptionTitleProvider.notifier).state = result;
    }
  }
}

class _TextWidget extends ConsumerWidget {
  const _TextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(subscriptionTitleProvider),
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.midnightBlue,
          fontSize: 18),
    );
  }
}
