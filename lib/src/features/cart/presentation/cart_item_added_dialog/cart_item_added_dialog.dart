import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/cart/application/cart_service.dart';
import 'package:widam/src/features/recommendations/presentation/frequently_bought_together/frequently_bought_together.dart';

import '../../../../../generated/l10n.dart';

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
          Consumer(builder: (context, ref, child) {
            if (!ref.watch(isMubadaraCartProvider)) {
              return const FrequentlyBoughtTogether();
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
