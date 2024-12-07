import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';

import '../../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../domain/cart/cart_content.dart';
import 'cart_controller.dart';
import 'cart_item/cart_item.dart';

class UnavailableItems extends ConsumerWidget {
  const UnavailableItems({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(cartControllerProvider, (previous, next) {
      if ((next is AsyncData && next.asData?.value == null) ||
          (next is AsyncData &&
              !(hasUnavailableItems(
                      next.asData?.value?.cartContent.normalDelivery) ||
                  hasUnavailableItems(
                      next.asData?.value?.cartContent.expressDelivery) ||
                  hasUnavailableItems(
                      next.asData?.value?.cartContent.pickupDelivery)))) {
        context.maybePop();
      }
    });
    final cartAsync = ref.watch(cartControllerProvider);
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: cartAsync.when(
            data: (cart) {
              if (cart == null) return const SizedBox.shrink();
              final unavailableItems = _getUnavailableItems(cart.cartContent);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).theseItemsAreNotAvailable,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 20.0),
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return CartItem(itemDetails: (unavailableItems[index]));
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      shrinkWrap: true,
                      itemCount: unavailableItems.length),
                ],
              );
            },
            error: (error, stackTrace) =>
                AppBanner(message: error.toString(), stackTrace: stackTrace),
            loading: () => const FadeCircleLoadingIndicator()),
      ),
    );
  }

  List<dynamic> _getUnavailableItems(CartContent cartContent) {
    List<dynamic> unavailableItems = [];
    if (cartContent.normalDelivery != null) {
      unavailableItems.addAll(cartContent.normalDelivery!.websiteItems
          .where((element) => element.inStock == 0));
    }
    if (cartContent.expressDelivery != null) {
      unavailableItems.addAll(cartContent.expressDelivery!.websiteItems
          .where((element) => element.inStock == 0));
    }
    if (cartContent.pickupDelivery != null) {
      unavailableItems.addAll(cartContent.pickupDelivery!.websiteItems
          .where((element) => element.inStock == 0));
    }
    return unavailableItems;
  }
}
