import 'package:flutter/material.dart';

import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../items/domain/item/item.dart';
import '../../../items/presentation/item_card/express_widget.dart';
import '../../../items/presentation/item_card/item_add_to_cart_button.dart';
import '../../../items/presentation/item_card/item_container.dart';
import '../../../items/presentation/item_card/item_price_row.dart';
import '../../../items/presentation/item_card/item_title.dart';
import '../../../items/presentation/item_card/item_unit.dart';
import '../../../items/presentation/item_card/stock_banner.dart';
import 'discount_banner.dart';

class DealsItem extends StatelessWidget {
  const DealsItem({Key? key, required this.item, this.attributionToken}) : super(key: key);
  final Item item;
  final String? attributionToken;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ItemContainer(
            width: double.infinity,
            item: item,
            attributionToken: attributionToken,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: item.price.discountTitle != null && item.inStock == 1
                        ? Stack(
                            children: [
                              AppCachedNetworkImage(
                                  imageUrl: item.websiteItemImage,
                                  fit: BoxFit.fitWidth),
                              PositionedDirectional(
                                  top: 0,
                                  start: 0,
                                  child: DiscountBanner(
                                      discountText: item.price.discountTitle!))
                            ],
                          )
                        : AppCachedNetworkImage(
                            imageUrl: item.websiteItemImage)),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemTitle(title: item.websiteItemName),
                      const SizedBox(height: 6),
                      ItemPriceRow(item: item),
                      const SizedBox(height: 5),
                      ItemUnit(stockUom: item.stockUom),
                      if (item.isExpressItem == 1) ...[
                        const SizedBox(height: 6),
                        const ExpressWidget(),
                      ],
                      const SizedBox(height: 3),
                      ItemAddToCartButton(item: item, attributionToken: attributionToken)
                    ],
                  ),
                )
              ],
            )),
        if (item.inStock == 0) ...[
          Positioned.fill(
              child: Container(
            color: Colors.white.withOpacity(0.5),
          )),
          const Positioned(top: 12, child: StockBanner(fontSize: 10))
        ]
      ],
    );
  }
}
