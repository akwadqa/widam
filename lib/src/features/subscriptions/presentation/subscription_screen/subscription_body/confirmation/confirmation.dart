import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_info/subscription_info_controller.dart';
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_info/subscription_title_controller.dart';
import 'package:widam/src/theme/app_theme.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../block_title.dart';
import 'send_subscription_controller.dart';
import 'subscription_title.dart';

import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../common_widgets/submit_button.dart';
import '../../../../../../theme/app_colors.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Assets.images.subscriptionImage.svg(),
                    const SubscriptionTitle(),
                    const SizedBox(height: 12),
                    const _SubscriptionSubTitle(),
                    const SizedBox(height: 12),
                    Text(S.of(context).subscriptionDescription,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    BlockTitle(title: S.of(context).subscriptionDetails),
                    const SizedBox(height: 8),
                    const _DetailsContainer(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              ref.listen(sendSubscriptionAsyncProvider, (previous, next) {
                if (next.value != null) {
                  context.maybePop();
                } else if (next.hasError) {
                  showAppBannerDialog(
                      context, next.error.toString(), next.stackTrace);
                }
              });
              final sendSubscriptionController =
                  ref.watch(sendSubscriptionAsyncProvider);
              if (sendSubscriptionController is AsyncLoading) {
                return const FadeCircleLoadingIndicator();
              }
              return SubmitButton(
                  text: S.of(context).confirm,
                  onPressed: ref
                      .read(sendSubscriptionAsyncProvider.notifier)
                      .sendSubscription);
            }),
            SizedBox(height: 20 + getBottomPadding(context)),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionSubTitle extends ConsumerWidget {
  const _SubscriptionSubTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return RichText(
      text: TextSpan(
        text: '${S.of(context).yourSubscription} ',
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: fontFamily),
        children: [
          TextSpan(
            text: ref.watch(subscriptionTitleControllerProvider),
            style: const TextStyle(
              color: AppColors.lapisBlue,
            ),
          ),
          TextSpan(text: '\n${S.of(context).isReadyForSubmission}'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _CustomText extends StatelessWidget {
  final String text;

  const _CustomText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _DetailsContainer extends StatelessWidget {
  const _DetailsContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.brightGray, width: 0.5),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CustomText(text: S.of(context).startDate),
              const SizedBox(height: 8),
              _CustomText(text: S.of(context).endDate),
              const SizedBox(height: 8),
              _CustomText(text: S.of(context).frequency),
              const SizedBox(height: 8),
              _CustomText(text: S.of(context).quantity),
            ],
          ),
          Consumer(builder: (context, ref, child) {
            final subscriptionInfo =
                ref.watch(subscriptionInfoControllerProvider);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _CustomText(text: subscriptionInfo.startDate),
                const SizedBox(height: 8),
                _CustomText(text: subscriptionInfo.endDate),
                const SizedBox(height: 8),
                _CustomText(text: subscriptionInfo.interval.frequencyName),
                const SizedBox(height: 8),
                _CustomText(text: subscriptionInfo.items.length.toString()),
              ],
            );
          })
        ],
      ),
    );
  }
}
