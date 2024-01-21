import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/layouts/presentation/item/items_horizontal_list.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../../items/domain/item/item.dart';
import '../../data/recommendations_repository.dart';

class Recommendations extends ConsumerWidget {
  const Recommendations({super.key, required this.quatationId});
  final String quatationId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsync =
        ref.watch(recommendationsProvider(quatationId));
    return recommendationsAsync.when(
        data: (recommendations) {
          if (recommendations.websiteItems.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
            color: AppColors.feijoa.withOpacity(0.15),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.centerStart,
                children: [
                  ItemsHorizontalList(
                      padding:
                          const EdgeInsetsDirectional.only(start: 50, end: 10),
                      items: recommendations.websiteItems
                          .map((e) => Item(
                              websiteItemId: e.websiteItemId,
                              websiteItemName: e.websiteItemName,
                              websiteItemShortName: e.websiteItemShortName,
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
                              hasProductOptions:
                                  e.productOptions.isNotEmpty ? 1 : 0))
                          .toList()),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 320,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.vividCerulean,
                      borderRadius: BorderRadiusDirectional.horizontal(
                          end: Radius.circular(8.0)),
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final lang = ref.watch(currentLanguageProvider);
                        return RotatedBox(
                          quarterTurns: lang == 'en' ? 3 : 1,
                          child: Text(
                            S.of(context).recommendations,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  )
                ]),
          );
        },
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink());
  }
}
