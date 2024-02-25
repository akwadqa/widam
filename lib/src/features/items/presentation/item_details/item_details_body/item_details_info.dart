import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/small_red_container.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/slotter_fees_widget/slotter_fees_controller.dart';
import '../../../domain/item_details/item_details.dart';
import 'quantity_form_field.dart';
import '../../../../../theme/app_colors.dart';

class ItemDetailsInfo extends StatelessWidget {
  const ItemDetailsInfo({super.key, required this.itemDetails});
  final ItemDetails itemDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(itemDetails.websiteItemName,
            style: const TextStyle(
                color: AppColors.raisinBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 3),
        Text(itemDetails.stockUom,
            style: const TextStyle(fontSize: 16, color: AppColors.taupeGray)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (itemDetails.price.discountAmount > 0) ...[
                  const SizedBox(height: 10),
                  SmallRedContainer(text: itemDetails.price.discountTitle!),
                  const SizedBox(height: 10),
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final priceModifier =
                            ref.watch(slotterFeesControllerProvider)
                                ? itemDetails.priceModifier!
                                : 0;
                        final price =
                            itemDetails.price.discountedPrice + priceModifier;
                        return Text('${itemDetails.price.currency} $price',
                            style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.midnightBlue,
                                fontWeight: FontWeight.bold));
                      },
                    ),
                    if (itemDetails.price.discountAmount > 0) ...[
                      const SizedBox(width: 8),
                      Text(itemDetails.price.websiteItemPrice.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.screamingGrey,
                              decoration: TextDecoration.lineThrough)),
                    ]
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.6),
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    )
                  ]),
              padding: EdgeInsets.zero,
              child: IntrinsicHeight(
                child: QuantityFormField(
                  maxQty: itemDetails.maxQty.toInt(),
                  minQty: itemDetails.minQty.toInt(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
