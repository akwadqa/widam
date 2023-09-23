import 'package:flutter/material.dart';
import 'package:widam/src/features/loyalty_points/domain/loyalty_program/loyalty_program.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class LoyaltyPointsCard extends StatelessWidget {
  const LoyaltyPointsCard({super.key, required this.loyaltyProgram});
  final LoyaltyProgram loyaltyProgram;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.hexToColor(loyaltyProgram.activeTier.tierColor)
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Assets.images.pattern.image(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).avaliablePoints,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(height: 4),
                            Text(
                                loyaltyProgram.earnedPoints.pointsBalance
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.hexToColor(
                                loyaltyProgram.activeTier.tierColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text(loyaltyProgram.activeTier.tierName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).loyaltyPointsValue,
                            style: const TextStyle(color: Colors.black)),
                        Text(
                            '${loyaltyProgram.earnedPoints.value} ${S.of(context).qar}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.hexToColor(
                        loyaltyProgram.activeTier.tierColor),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    )),
                padding: const EdgeInsets.only(
                    top: 5, left: 20, right: 20, bottom: 10),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loyaltyProgram.expiringPoints.expiringPointsTotal} ${S.of(context).pointsExpiringWithIn}',
                      ),
                      Text(
                        loyaltyProgram.expiringPoints.window,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
