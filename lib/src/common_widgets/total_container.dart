import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/utils/utils.dart';

import '../../generated/l10n.dart';
import '../features/cart/domain/cart/cart.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class TotalContainer extends StatelessWidget {
  const TotalContainer(
      {super.key,
      required this.cart,
      required this.button,
      required this.orderTotal});
  final Cart cart;
  final Widget button;
  final double orderTotal;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.brightGray),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 16,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(-3, 0))
          ]),
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CountText(count: cart.totalQty.toInt().toString()),
            _TotalText(
                total: orderTotal.toStringAsFixed(2), currency: cart.currency)
          ],
        ),
        const SizedBox(height: 16),
        button,
        SizedBox(height: getBottomPadding(context))
      ]),
    );
  }
}

class _CountText extends ConsumerWidget {
  const _CountText({required this.count});

  final String count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return RichText(
      text: TextSpan(
        style: TextStyle(
            color: AppColors.darkGray,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        children: [
          TextSpan(
            text: S.of(context).orderTotal,
          ),
          const TextSpan(
            text: ' (',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: '$count ${S.of(context).items}',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.screamingGrey),
          ),
          const TextSpan(
            text: ')',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalText extends ConsumerWidget {
  const _TotalText({required this.total, required this.currency});
  final String total;
  final String currency;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(fontFamilyProvider);
    return RichText(
        text: TextSpan(
            style: TextStyle(color: Colors.black, fontFamily: fontFamily),
            children: [
          TextSpan(
            text: '$total ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: currency,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]));
  }
}
