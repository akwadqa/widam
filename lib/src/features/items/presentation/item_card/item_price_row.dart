import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../domain/item/item.dart';

class ItemPriceRow extends StatelessWidget {
  const ItemPriceRow({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(item.price.currency,
            style: const TextStyle(
                fontSize: 12,
                color: AppColors.raisinBlack,
                fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        Text(item.price.discountedPrice.toString(),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.raisinBlack)),
        if (item.price.discountAmount > 0) ...[
          const SizedBox(width: 6),
          Text(item.price.websiteItemPrice.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.screamingGrey,
                  decoration: TextDecoration.lineThrough)),
        ]
      ],
    );
  }
}
