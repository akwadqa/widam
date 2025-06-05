import 'package:flutter/material.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/items/domain/item_details/item_details.dart';

import '../../../common_widgets/app_cached_network_image.dart';
import '../../../theme/app_colors.dart';

class RecommendationItemsList extends StatelessWidget {
  const RecommendationItemsList(
      {super.key,
      required this.items,
      required this.onAddToCart,
      required this.itemIdLoading});

  final List<ItemDetails> items;
  final void Function(String websiteItemId, String itemWarehouseId, int quantity) onAddToCart;
  final String? itemIdLoading;

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemBuilder: (context, index) {
          final disableItem=items[index].status=="Disabled";
          return 
          disableItem?SizedBox():
          SizedBox(
            width: 90,
            child: InkWell(
              onTap: () => onAddToCart(items[index].websiteItemId, items[index].warehouse.warehouseId, 1),
              child: Column(
                children: [
                  AppCachedNetworkImage(
                      imageUrl: items[index].additionalImages.first.image,
                      fit: BoxFit.fitWidth,
                      height: 70,
                      width: 70),
                  Expanded(
                    child: Text(
                      items[index].websiteItemShortName ?? '',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  itemIdLoading == items[index].websiteItemId
                      ? const FadeCircleLoadingIndicator()
                      : IconButton(
                          onPressed: () =>
                              onAddToCart(items[index].websiteItemId, items[index].warehouse.warehouseId, 1),
                          icon: Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ))
                ],
              ),
            ),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 20),
        itemCount: items.length);
  }
}
