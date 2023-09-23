import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/items/domain/item/item.dart';
import 'package:widam/src/features/recommendations/presentation/frequently_bought_together/frequently_bought_together_controller.dart';

import '../../../../theme/app_colors.dart';
import '../../../items/presentation/item_card/item_card.dart';
import '../../../layouts/presentation/item/mubadara_item.dart';

class FrequentlyBoughtTogether extends ConsumerWidget {
  const FrequentlyBoughtTogether({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frequentlyBoughtAsync =
        ref.watch(frequentlyBoughtTogetherControllerProvider);
    return frequentlyBoughtAsync.when(
      data: (frequentlyBought) {
        if (frequentlyBought != null && frequentlyBought.websiteItems.isEmpty) {
          return const SizedBox.shrink();
        }
        if (frequentlyBought != null) {
          final items = frequentlyBought.websiteItems
              .map((e) => Item(
                    websiteItemId: e.websiteItemId,
                    websiteItemName: e.websiteItemName,
                    websiteItemType: e.websiteItemType,
                    maxQty: e.maxQty,
                    minQty: e.minQty,
                    stockUom: e.stockUom,
                    websiteItemImage: e.additionalImages.first.image,
                    itemGroup: null,
                    isExpressItem: e.isExpressItem,
                    price: e.price,
                    tags: e.tags,
                    inStock: e.inStock,
                    isMubadara: e.mubadaraDetails != null ? 1 : 0,
                    mubadaraId: e.mubadaraDetails?.mubadaraId,
                    hasProductOptions: e.productOptions.isNotEmpty ? 1 : 0,
                  ))
              .toList();
          return Container(
            color: AppColors.cultured,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(S.of(context).frequentlyBoughtTogether,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 18)),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return items[index].isMubadara == 1
                        ? MubadaraItem(item: items[index])
                        : ItemCard(
                            item: items[index],
                            width: 130,
                            isFrequencyItem: true);
                  },
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ]),
          );
        }
        return const SizedBox.shrink();
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
