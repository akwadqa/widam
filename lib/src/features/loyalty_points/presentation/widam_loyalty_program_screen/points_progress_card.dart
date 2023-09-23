import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:widam/src/features/loyalty_points/domain/loyalty_program/loyalty_program.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class PointsProgressCard extends StatelessWidget {
  const PointsProgressCard({super.key, required this.loyaltyProgram});
  final LoyaltyProgram loyaltyProgram;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ghostWhite,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loyaltyProgram.activeTier.tierName,
              style: const TextStyle(
                  color: AppColors.lapisBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (loyaltyProgram.nextTier != null) ...[
            StepProgressIndicator(
              totalSteps:
                  loyaltyProgram.nextTier!.minimumTotalToQualify.toInt(),
              currentStep:
                  loyaltyProgram.activeTier.minimumTotalToQualify.toInt(),
              size: 8,
              padding: 0,
              selectedColor: AppColors.vividCerulean,
              unselectedColor: AppColors.pattensBlue,
              roundedEdges: const Radius.circular(4),
            ),
            const SizedBox(height: 8),
            Consumer(
              builder: (context, ref, child) {
                final fontFamily = ref.watch(fontFamilyProvider);
                return RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: fontFamily,
                      color: AppColors.lapisBlue,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '${S.of(context).minimum} ${loyaltyProgram.nextTier!.minimumTotalToQualify} ${S.of(context).qar} ${S.of(context).toUnlock} '),
                      TextSpan(
                        text: loyaltyProgram.nextTier!.tierName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
          IntrinsicHeight(
            child: Row(
              children: [
                PointsColumn(
                  amount: loyaltyProgram.earnedPoints.totalEarned.toString(),
                  unit: S.of(context).points,
                  title: S.of(context).totalEarned,
                ),
                const Spacer(),
                _verticalDivider,
                const Spacer(),
                PointsColumn(
                  amount: loyaltyProgram.earnedPoints.totalRedeemed.toString(),
                  unit: S.of(context).points,
                  title: S.of(context).totalRedeemed,
                ),
                const Spacer(),
                _verticalDivider,
                const Spacer(),
                PointsColumn(
                  amount: loyaltyProgram.earnedPoints.value.toString(),
                  unit: S.of(context).qar,
                  title: S.of(context).totalSaving,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () => context.pushRoute(const PointsHistoryScreen()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).moreDetails,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  const Icon(Icons.arrow_forward_ios, size: 16)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  VerticalDivider get _verticalDivider =>
      const VerticalDivider(color: AppColors.customBlue, thickness: 2);
}

class PointsColumn extends StatelessWidget {
  const PointsColumn(
      {super.key,
      required this.amount,
      required this.unit,
      required this.title});
  final String amount;
  final String unit;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(amount,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.lapisBlue)),
        const SizedBox(height: 2),
        Text(unit,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.lapisBlue)),
        const SizedBox(height: 2),
        Text(title,
            style:
                const TextStyle(fontSize: 14, color: AppColors.candyAppleRed)),
      ],
    );
  }
}
