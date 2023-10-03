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
  final void Function(String websiteItemId, int quantity) onAddToCart;
  final String? itemIdLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onAddToCart(items[index].websiteItemId, 1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AppCachedNetworkImage(
                      imageUrl: items[index].additionalImages.first.image,
                      fit: BoxFit.fitHeight,
                      height: 70,
                      width: 70),
                ),
                itemIdLoading == items[index].websiteItemId
                    ? const FadeCircleLoadingIndicator()
                    : IconButton(
                        onPressed: () =>
                            onAddToCart(items[index].websiteItemId, 1),
                        icon: Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ))
              ],
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
