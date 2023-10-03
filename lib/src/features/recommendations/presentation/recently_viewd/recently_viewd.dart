import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/recommendations/presentation/recently_viewd/recently_viewd_controller.dart';

import '../../../../../generated/l10n.dart';
import '../../../cart/presentation/cart_body/cart_container.dart';
import '../recommendation_items_list.dart';

class RecentlyViewd extends ConsumerWidget {
  const RecentlyViewd({super.key, required this.quotationId});
  final String quotationId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyViewdAsync =
        ref.watch(recentlyViewdControllerProvider(quotationId));
    return recentlyViewdAsync.when(
        data: (recentlyViewdResponse) {
          if (recentlyViewdResponse
              .recommendationResponse.websiteItems.isEmpty) {
            return const SizedBox.shrink();
          }
          return CartContainer(
              withoutPadding: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(S.of(context).recentlyViewed,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    color: Colors.white,
                    height: 130.0,
                    child: RecommendationItemsList(
                        items: recentlyViewdResponse
                            .recommendationResponse.websiteItems,
                        onAddToCart: (websiteItemId, quantity) {
                          ref
                              .read(recentlyViewdControllerProvider(quotationId)
                                  .notifier)
                              .addToCart(websiteItemId, quantity);
                        },
                        itemIdLoading: recentlyViewdResponse.itemIdLoading),
                  )
                ],
              ));
        },
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink());
  }
}
