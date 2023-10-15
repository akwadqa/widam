import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/cart/presentation/add_to_cart_button/quantity_controller.dart';
import '../../../../common_widgets/item_oprions_button.dart';
import '../../../../routing/app_router.gr.dart';
import '../../../auth/application/user_data_provider.dart';
import '../../../cart/application/cart_service.dart';
import '../../domain/item/item.dart';
import '../../../cart/presentation/add_to_cart_button/add_to_cart_button.dart';
import 'circle_button.dart';

class ItemAddToCartButton extends StatelessWidget {
  const ItemAddToCartButton(
      {Key? key, required this.item, this.attributionToken})
      : super(key: key);
  final Item item;
  final String? attributionToken;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: item.websiteItemType == 'V' || item.isMubadara == 1
            ? ItemOprionsButton(item: item)
            : Consumer(
                builder: (context, ref, child) {
                  final userToken = ref.watch(userDataProvider);
                  if (userToken == null) {
                    return CircleButton(
                      onTap: () => context.pushRoute(const LoginScreen()),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    );
                  }
                  return ProviderScope(
                    overrides: [
                      updateCartProvider.overrideWith(() => UpdateCart()),
                      quantityControllerProvider.overriddenFamily
                    ],
                    child: AddToCartButton(
                      itemId: item.websiteItemId,
                      maxQuantity: item.maxQty.toInt(),
                      minQuantity: item.minQty.toInt(),
                      attributionToken: attributionToken,
                    ),
                  );
                },
              ));
  }
}
