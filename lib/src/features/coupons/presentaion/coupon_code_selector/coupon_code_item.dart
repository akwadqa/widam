import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../generated/l10n.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../domain/coupon/coupon.dart';

class CouponCodeItem extends StatelessWidget {
  const CouponCodeItem({super.key, required this.coupon});
  final Coupon coupon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.brightGray, width: 0.5),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: const Offset(0, 0),
                blurRadius: 2)
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(coupon.couponCodeId,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 6.0),
        Text(coupon.description,
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DottedBorder(
                child: Container(
              color: AppColors.cultured,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(coupon.couponCode,
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.midnightBlue)),
            )),
            Consumer(
              builder: (context, ref, child) {
                final fontFamily = ref.watch(fontFamilyProvider);
                return TextButton(
                    onPressed: () => context.maybePop(coupon.couponCode),
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.midnightBlue,
                        textStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamily)),
                    child: Text(S.of(context).apply,
                        style: const TextStyle(fontSize: 16)));
              },
            )
          ],
        )
      ]),
    );
  }
}
