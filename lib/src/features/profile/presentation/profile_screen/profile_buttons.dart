import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../../theme/app_colors.dart';
import '../../../auth/application/user_data_provider.dart';

class ProfileButtons extends ConsumerWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = ref.watch(userDataProvider);
    if (userToken != null) {
      return Container(
        color: AppColors.cultured,
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Button(
                image: Assets.icons.folderIcon.svg(
                    colorFilter: const ColorFilter.mode(
                        AppColors.darkBlue, BlendMode.srcIn)),
                text: S.of(context).activeSubscription,
                onTap: () =>
                    context.pushRoute(const ActiveSubscriptionsScreen())),
            _Button(
                image: Assets.icons.pastOrdersIcon.svg(),
                text: S.of(context).orders,
                onTap: () =>
                    context.pushRoute(SalesOrdersScreen()).then((value) {
                      if (value == true) {
                        context.tabsRouter.setActiveIndex(3);
                      }
                    })),
            _Button(
                image: Assets.icons.folderIcon.svg(
                    colorFilter: const ColorFilter.mode(
                        AppColors.darkBlue, BlendMode.srcIn)),
                text: S.of(context).subscribe,
                onTap: () => context.pushRoute(const SubscriptionScreen())),
            _Button(
                image: Assets.icons.couponsIcon.svg(),
                text: S.of(context).yourCoupons,
                onTap: () => context.pushRoute(const UdhiyaCouponsScreen())),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _Button extends StatelessWidget {
  final Widget image;
  final String text;
  final VoidCallback onTap;

  const _Button({required this.image, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.babyBlue,
              child: image,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
