import 'package:flutter/material.dart';
import 'package:widam/src/common_widgets/small_red_container.dart';
import 'package:widam/src/features/items/presentation/item_card/stock_banner.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../tags/presentation/item_tag_label_list.dart';
import '../../../tags/presentation/item_tags_list/item_tags_list.dart';
import '../../domain/item/item.dart';
import 'express_widget.dart';
import 'item_add_to_cart_button.dart';
import 'item_container.dart';
import 'item_price_row.dart';
import 'item_title.dart';
import 'item_unit.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.item,
      this.width = 180,
      this.isFrequencyItem = false,
      this.attributionToken});
  final Item item;
  final double width;
  final bool isFrequencyItem;
  final String? attributionToken;
  @override
  Widget build(BuildContext context) {
    return ItemContainer(
      width: width,
      item: item,
      attributionToken: attributionToken,
      isFrequencyItem: isFrequencyItem,
      child: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                    child: AppCachedNetworkImage(
                        fit: BoxFit.fitWidth, imageUrl: item.websiteItemImage)),
                if (item.tags
                        .where((element) => element.productLabel == 1)
                        .isNotEmpty &&
                    item.inStock == 1)
                  PositionedDirectional(
                      top: 8,
                      start: 0,
                      child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: SizedBox(
                              width: 100,
                              child: ItemTagLabelList(tags: item.tags)))),
                if (item.tags
                        .where((element) => element.productLabel == 0)
                        .isNotEmpty &&
                    item.inStock == 1 &&
                    !isFrequencyItem)
                  PositionedDirectional(
                      top: 8,
                      end: 0,
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: SizedBox(
                          width: 40,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 4.0),
                            child: ItemTagsList(tags: item.tags),
                          ),
                        ),
                      )),
                if (item.isExpressItem == 1) ...[
                  const PositionedDirectional(
                    bottom: 6,
                    start: 6,
                    child: ExpressWidget(),
                  ),
                ],
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemTitle(
                      title: item.websiteItemName,
                      maxLines: isFrequencyItem ? 1 : null),
                  const SizedBox(height: 5),
                  ItemPriceRow(item: item),
                  if (item.price.discountTitle != null) ...[
                    const SizedBox(height: 5),
                    SmallRedContainer(
                        text: item.price.discountTitle!,
                        maxLines: isFrequencyItem ? 1 : null),
                  ],
                  const SizedBox(height: 5),
                  ItemUnit(stockUom: item.stockUom),
                  const SizedBox(height: 2),
                  ItemAddToCartButton(
                      item: item, attributionToken: attributionToken)
                ],
              ),
            )
          ]),
          if (item.inStock == 0) ...[
            Positioned.fill(
                child: Container(
              color: Colors.white.withOpacity(0.5),
            )),
            const Positioned(top: 12, child: StockBanner())
          ]
        ],
      ),
    );
  }
}
