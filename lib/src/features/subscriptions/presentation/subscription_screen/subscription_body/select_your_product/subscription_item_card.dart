import 'package:flutter/material.dart';
import 'package:widam/src/features/items/presentation/item_card/stock_banner.dart';
import '../../../../../../common_widgets/app_cached_network_image.dart';
import 'subscribe_button.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../items/domain/item/item.dart';
import '../../../../../items/presentation/item_card/item_unit.dart';

class SubscriptionItemCard extends StatelessWidget {
  const SubscriptionItemCard({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: AppCachedNetworkImage(
                            imageUrl: item.websiteItemImage)),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.websiteItemName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGray)),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: AppColors.raisinBlack,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '${item.price.currency} ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.price.discountedPrice
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ItemUnit(stockUom: item.stockUom),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: SubscribeButton(item: item),
                )
              ],
            ),
          ),
          if (item.inStock == 0) ...[
            Positioned.fill(
                child: Container(
              color: Colors.white.withOpacity(0.5),
            )),
            const PositionedDirectional(
                top: 40, end: 0, child: StockBanner(oppositeDirection: true))
          ]
        ],
      ),
    );
  }
}
