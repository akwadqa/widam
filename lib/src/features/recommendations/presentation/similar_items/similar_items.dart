import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/cart/domain/cart/cart.dart';
import 'package:widam/src/features/recommendations/presentation/recommendation_items_list.dart';
import 'package:widam/src/features/recommendations/presentation/similar_items/similar_items_controller.dart';

import '../../../../../generated/l10n.dart';
import '../../../cart/presentation/cart_body/cart_container.dart';

class SimiliarItems extends ConsumerWidget {
  const SimiliarItems({
    super.key,
    required this.quotationId,
  });
  final String quotationId;
  // final Cart cart;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarItemsAsync =
        ref.watch(similarItemsControllerProvider(quotationId));
    return similarItemsAsync.when(
        data: (similarItemsResponse) {
//  final items =
//               similarItemsResponse.recommendationResponse.websiteItems;
// debugPrint("item.isUdhiyaItem => ${items[0].isUdhiyaItem}");
//           final hasUdhiyaOrMubadra = items.any(
//             (item) => item.isUdhiyaItem == 1
//           );

//           if (items.isEmpty || hasUdhiyaOrMubadra) {
//             return const SizedBox.shrink();
//           }

          if (similarItemsResponse
              .recommendationResponse.websiteItems.isEmpty) {
            return const SizedBox.shrink();
          }
          return CartContainer(
              withoutPadding: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(S.of(context).customersAlsoBought,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    color: Colors.white,
                    height: 150.0,
                    child: RecommendationItemsList(
                        items: similarItemsResponse
                            .recommendationResponse.websiteItems,
                        onAddToCart:
                            (websiteItemId, itemWarehouseId, quantity) {
                          ref
                              .read(similarItemsControllerProvider(quotationId)
                                  .notifier)
                              .addToCart(
                                  websiteItemId, itemWarehouseId, quantity);
                        },
                        itemIdLoading: similarItemsResponse.itemIdLoading),
                  )
                ],
              ));
        },
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink());
  }
}
