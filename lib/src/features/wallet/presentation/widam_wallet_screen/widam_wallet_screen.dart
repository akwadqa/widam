import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/titled_image.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

@RoutePage()
class WidamWalletScreen extends StatelessWidget {
  const WidamWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).widamWallet),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitledImage(
                title: S.of(context).widamWallet,
                icon: Assets.images.walletImage.svg()),
            Text(S.of(context).widamWalletDescription,
                style: const TextStyle(fontSize: 14, color: AppColors.gray)),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.summerdayBlue, width: 0.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              child: Consumer(
                builder: (context, ref, child) {
                  final walletBalence = ref
                      .watch(appDataControllerProvider)
                      .asData
                      ?.value
                      .walletBalance;
                  return Text('$walletBalence ${S.of(context).qar}',
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600));
                },
              ),
            ),
            const SizedBox(height: 50),
            Consumer(
              builder: (context, ref, child) {
                final fontFamily = ref.watch(fontFamilyProvider);
                return TextButton(
                    onPressed: () =>
                        context.pushRoute(const TransactionHistoryScreen()),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkBlue,
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: fontFamily),
                    ),
                    child: Text(S.of(context).transactionHistory));
              },
            )
          ],
        ),
      ),
    );
  }
}
