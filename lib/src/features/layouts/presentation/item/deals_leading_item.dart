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

class DealsLeadingItem extends StatelessWidget {
  const DealsLeadingItem({Key? key, required this.item, this.attributionToken}) : super(key: key);
  final Item item;
  final String? attributionToken;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ItemContainer(
            width: double.infinity,
            item: item,
            child: item.price.discountTitle != null && item.inStock == 1
                ? Stack(
                    children: [
                      _DealsRow(item: item, attributionToken: attributionToken),
                      DiscountBanner(discountText: item.price.discountTitle!),
                    ],
                  )
                : _DealsRow(item: item, attributionToken: attributionToken)),
        if (item.inStock == 0) ...[
          Positioned.fill(
              child: Container(
            color: Colors.white.withOpacity(0.5),
          )),
          const Positioned(top: 12, child: StockBanner())
        ]
      ],
    );
  }
}

class _DealsRow extends StatelessWidget {
  const _DealsRow({
    required this.item, this.attributionToken,
  });

  final Item item;
  final String? attributionToken;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: AppCachedNetworkImage(
              imageUrl: item.websiteItemImage, fit: BoxFit.fitWidth),
        ),
        const Spacer(),
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemTitle(title: item.websiteItemName),
                  const SizedBox(height: 6),
                  ItemPriceRow(item: item),
                  const SizedBox(height: 4),
                  ItemUnit(stockUom: item.stockUom),
                  if (item.isExpressItem == 1) ...[
                    const SizedBox(height: 6),
                    const ExpressWidget(),
                    const SizedBox(height: 6),
                  ],
                  ItemAddToCartButton(item: item, attributionToken: attributionToken)
                ],
              ),
            )),
      ],
    );
  }
}
