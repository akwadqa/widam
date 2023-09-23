import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';
import '../../../../routing/app_router.gr.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../../../addresses/domain/address/address.dart';
import '../../../addresses/presentation/addresses/addresses_selector/addresses_selector.dart';
import '../../../auth/application/user_data_provider.dart';
import '../../../subscriptions/presentation/subscription_screen/subscription_body/set_your_schedule/subscription_address_controller.dart';

class ButtonsRow extends ConsumerWidget {
  const ButtonsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(userDataProvider) != null;
    return Row(
      children: [
        Expanded(
          child: Consumer(builder: (context, ref, child) {
            final defaultAddress =
                ref.watch(appDataControllerProvider).asData?.value.address;
            return _CustomButton(
                icon: Assets.icons.folderIcon.svg(height: 35),
                color: AppColors.orange,
                title: S.of(context).autoOrder,
                onTap: () {
                  if (isLoggedIn) {
                    if (defaultAddress != null) {
                      context.pushRoute(const SubscriptionScreen());
                    } else {
                      showAdaptiveModalBottomSheet<Address?>(
                              context: context,
                              builder: (ctx) => const AddressesSelector())
                          .then((address) {
                        if (address != null) {
                          ref
                              .read(subscriptionAddressControllerProvider
                                  .notifier)
                              .changeAddress(address);
                          context.pushRoute(const SubscriptionScreen());
                        }
                      });
                    }
                  } else {
                    context.pushRoute(const LoginScreen());
                  }
                });
          }),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _CustomButton(
            icon: Assets.icons.cartAgainIcon.svg(height: 35),
            color: AppColors.secondary,
            title: S.of(context).orderAgain,
            onTap: () {
              if (isLoggedIn) {
                context.pushRoute(SalesOrdersScreen(initialIndex: 0));
              } else {
                context.pushRoute(const LoginScreen());
              }
            },
          ),
        ),
      ],
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton(
      {Key? key,
      required this.icon,
      required this.color,
      required this.onTap,
      required this.title})
      : super(key: key);
  final Widget icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(2);
    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            color: AppColors.lightGray,
          ),
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 8),
              icon,
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: radius,
                ),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
