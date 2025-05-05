import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/loyalty_program_controller.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/redeem_points_controller.dart';

class RedeemPointsButton extends ConsumerWidget {
  const RedeemPointsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(redeemPointsControllerProvider, (previous, next) {
      if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      }
      if (next is AsyncData && next.asData?.value != null) {
        ref.read(loyaltyProgramControllerProvider.notifier).getLoyaltyProgram();
      }
    });
    if (ref.watch(redeemPointsControllerProvider) is AsyncLoading) {
      return const FadeCircleLoadingIndicator();
    }
    return SubmitButton(
        text: S.of(context).redeemYourPoints,
        onPressed: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                    title: Text(S.of(context).areYouSure),
                    content: Text(S.of(context).redeemPointsConfirmation),
                    actions: [
                      TextButton(
                          onPressed: context.maybePop,
                          child: Text(S.of(context).no)),
                      TextButton(
                          onPressed: () {
                            context.maybePop();
                            ref
                                .read(redeemPointsControllerProvider.notifier)
                                .redeemPoints();
                          },
                          child: Text(S.of(context).yes))
                    ],
                  ));
        });
  }
}
