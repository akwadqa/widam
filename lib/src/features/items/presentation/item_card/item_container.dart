import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../../domain/item/item.dart';

class ItemContainer extends ConsumerWidget {
  const ItemContainer(
      {super.key,
      required this.width,
      required this.child,
      required this.item,
      this.customBoxShadow,
      this.attributionToken,
      this.isFrequencyItem = false});

  final double width;
  final Widget child;
  final Item item;
  final List<BoxShadow>? customBoxShadow;
  final String? attributionToken;
  final bool isFrequencyItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
        border: Border.all(
          color: AppColors.brightGray,
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Material(
        color: Colors.white,
        borderRadius: _borderRadius,
        child: InkWell(
            onTap: item.inStock == 0
                ? null
                : 
                isFrequencyItem
                    ?
                     () {
                        context.maybePop().then((value) {
                          context.pushRoute(ItemDetailsScreen(
                              itemId: item.websiteItemId,
                              mubadaraId: item.mubadaraId));
                        });
                      }
                    : () => navigateToItemDetails(
                        context: context,
                        ref: ref,
                        itemId: item.websiteItemId,
                        itemType: item.websiteItemType,
                        isMubadara: item.isMubadara,
                        mubadaraId: item.mubadaraId,
                        attributionToken: attributionToken),
            borderRadius: _borderRadius,
            child: child),
      ),
    );
  }

  BorderRadius get _borderRadius => BorderRadius.circular(5);
}
