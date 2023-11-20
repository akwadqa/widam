import 'package:flutter/material.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../items/presentation/item_card/item_container.dart';
import '../../../items/presentation/item_card/item_title.dart';
import '../../../../theme/app_colors.dart';
import '../../../items/domain/item/item.dart';
import '../../../items/presentation/item_card/item_add_to_cart_button.dart';

class MubadaraItem extends StatelessWidget {
  const MubadaraItem(
      {super.key, required this.item, this.width = 280, this.attributionToken});

  final Item item;
  final double width;
  final String? attributionToken;

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
        width: width,
        attributionToken: attributionToken,
        customBoxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 4,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        item: item,
        child: Column(
          children: [
            Expanded(
                child: AppCachedNetworkImage(
                    imageUrl: item.websiteItemImage,
                    width: double.infinity,
                    fit: BoxFit.fitWidth)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemTitle(title: item.websiteItemName),
                      const SizedBox(height: 4),
                      Text(
                          '${item.price.currency} ${item.price.discountedPrice}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.raisinBlack)),
                    ],
                  ),
                  ItemAddToCartButton(
                      item: item, attributionToken: attributionToken)
                ],
              ),
            )
          ],
        ));
  }
}
