import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/loyalty_program_controller.dart';
import 'package:widam/src/routing/app_router.gr.dart';

class LoyaltyProgramListTile extends ConsumerWidget {
  const LoyaltyProgramListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loyaltyProgramAsync = ref.watch(loyaltyProgramControllerProvider);
    if (ref.exists(loyaltyProgramControllerProvider) && context.mounted) {
      ref.listen(loyaltyProgramControllerProvider, (previous, next) {
        if (next is AsyncData && next.asData?.value != null) {
          if (next.asData?.value is LoyaltyProgramLoaded) {
            context.pushRoute(const WidamLoyaltyProgramScreen());
          } else {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog.adaptive(
                    content: Text(S.of(context).noLoyaltyProgramDesc),
                    actions: [
                      TextButton(
                          onPressed: context.maybePop,
                          child: Text(S.of(context).ok)),
                    ],
                  );
                });
          }
        } else if (next is AsyncError) {
          showAppBannerDialog(context, next.error.toString(), next.stackTrace);
        }
      });
    }
    if (loyaltyProgramAsync is AsyncLoading) {
      return const FadeCircleLoadingIndicator();
    }
    return ListTile(
      leading: Assets.icons.loyaltyIcon.svg(),
      title: Text(S.of(context).widamPoints),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => ref
          .read(loyaltyProgramControllerProvider.notifier)
          .getLoyaltyProgram(),
    );
  }
}
