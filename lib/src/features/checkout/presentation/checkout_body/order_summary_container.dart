import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../cart/domain/cart/cart.dart';

class OrderSummaryContainer extends StatelessWidget {
  const OrderSummaryContainer({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.brightGray, width: 0.5),
          borderRadius: BorderRadius.circular(2)),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultTextStyle.merge(
              style: const TextStyle(
                  fontSize: 13.0,
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).cartTotal),
                  const SizedBox(height: 10.0),
                  if (cart.pickup != 1) ...[
                    Text(S.of(context).deliveryFee),
                    const SizedBox(height: 10.0),
                  ],
                  Text(S.of(context).discount),
                ],
              ),
            ),
            DefaultTextStyle.merge(
              style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${cart.total.toStringAsFixed(2)} ${cart.currency}'),
                  const SizedBox(height: 10.0),
                  if (cart.pickup != 1) ...[
                    Text(
                        '${cart.totalCharges.toStringAsFixed(2)} ${cart.currency}'),
                    const SizedBox(height: 10.0),
                  ],
                  Text(
                      '${cart.totalDiscountAmount?.toStringAsFixed(2)} ${cart.currency}'),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15.0),
        const _DashedDivider(),
        const SizedBox(height: 15.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(S.of(context).total,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGray,
                  fontSize: 15)),
          Text('${cart.grandTotal.toStringAsFixed(2)} ${cart.currency}',
              style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))
        ])
      ]),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.silver),
              ),
            );
          }),
        );
      },
    );
  }
}
