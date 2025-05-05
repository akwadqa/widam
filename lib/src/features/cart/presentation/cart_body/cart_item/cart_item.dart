import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import '../../../../../common_widgets/app_cached_network_image.dart';
import '../../../../../common_widgets/small_red_container.dart';
import '../../add_to_cart_button/add_to_cart_button.dart';
import '../../../../items/domain/item_details/item_details.dart';

import '../../../../../theme/app_colors.dart';
import '../../../application/cart_service.dart';
import '../../add_to_cart_button/quantity_controller.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.itemDetails});
  final ItemDetails itemDetails;
  @override
  Widget build(BuildContext context) {
    final double opacity = itemDetails.inStock == 0 ? 0.4 : 1;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.brightGray, width: 0.5),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AppCachedNetworkImage(
                imageUrl: itemDetails.additionalImages.first.image, width: 80),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: opacity,
                  child: Text(itemDetails.websiteItemName,
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.darkGray,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 3),
                Opacity(
                  opacity: opacity,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${itemDetails.price.discountedPrice.toStringAsFixed(2)} ',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: itemDetails.price.currency,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (itemDetails.websiteItemAttributes != null &&
                    itemDetails.websiteItemAttributes!.isNotEmpty)
                  Opacity(
                    opacity: opacity,
                    child: Text(
                        itemDetails.websiteItemAttributes!
                                .map((e) =>
                                    '${e.attributeTitle}: ${e.attributeValue.valueTitle}')
                                .join('-') +
                            (itemDetails.customerQid != null
                                ? ' - QID: ${itemDetails.customerQid}'
                                : ''),
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.darkGray,
                            fontWeight: FontWeight.w500)),
                  ),
                if (itemDetails.inStock == 0) ...[
                  const SizedBox(height: 5),
                  SmallRedContainer(text: S.of(context).outOfStock),
                ],
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: ProviderScope(
                    overrides: [
                      updateCartProvider.overrideWith(() => UpdateCart()),
                      quantityControllerProvider.overriddenFamily
                    ],
                    child: AddToCartButton(
                      minQuantity: itemDetails.minQty.toInt(),
                      maxQuantity: itemDetails.maxQty.toInt(),
                      itemId: itemDetails.websiteItemId,
                      row: itemDetails.row,
                      inStock: itemDetails.inStock, itemWarehouseId: itemDetails.warehouse.warehouseId,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
