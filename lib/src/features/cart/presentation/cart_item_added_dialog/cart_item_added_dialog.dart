import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/cart/presentation/cart_item_added_dialog/go_to_cart_controller.dart';
import 'package:widam/src/features/recommendations/presentation/frequently_bought_together/frequently_bought_together.dart';
import '../../../../../generated/l10n.dart';

import '../../../../theme/app_colors.dart';

class CartItemAddedDialog extends StatelessWidget {
  const CartItemAddedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(S.of(context).youHaveItemsAddedToYourCart,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: context.popRoute,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary),
                    child: Text(S.of(context).continueShopping)),
                Consumer(
                  builder: (context, ref, child) {
                    return Consumer(
                      builder: (context, ref, child) {
                        return ElevatedButton(
                            onPressed: () {
                              context.router.popUntilRoot();
                              ref
                                  .read(goToTabControllerProvider.notifier)
                                  .goToCart();
                            },
                            child: Text(S.of(context).viewCart));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const FrequentlyBoughtTogether()
        ],
      ),
    );
  }
}
