// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:widam/src/routing/app_router.gr.dart';

// import '../../../../theme/app_colors.dart';
// import '../../../../utils/utils.dart';
// import '../../domain/item/item.dart';

// class ItemContainer extends ConsumerWidget {
//   const ItemContainer(
//       {super.key,
//       required this.width,
//       required this.child,
//       required this.item,
//       this.customBoxShadow,
//       this.attributionToken,
//       this.isFrequencyItem = false});

//   final double width;
//   final Widget child;
//   final Item item;
//   final List<BoxShadow>? customBoxShadow;
//   final String? attributionToken;
//   final bool isFrequencyItem;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       width: width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: _borderRadius,
//         border: Border.all(
//           color: AppColors.brightGray,
//           width: 0.5,
//         ),
//       ),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Material(
//         color: Colors.white,
//         borderRadius: _borderRadius,
//         child: InkWell(
//             onTap: item.inStock == 0
//                 ? null
//                 : 
//                 isFrequencyItem
//                     ?
//                      () {
//                         context.maybePop().then((value) {
//                           context.pushRoute(ItemDetailsScreen(
//                               itemId: item.websiteItemId,
//                               mubadaraId: item.mubadaraId));
//                         });
//                       }
//                     : () => navigateToItemDetails(
//                         context: context,
//                         ref: ref,
//                         itemId: item.websiteItemId,
//                         itemType: item.websiteItemType,
//                         isMubadara: item.isMubadara,
//                         mubadaraId: item.mubadaraId,
//                         attributionToken: attributionToken),
//             borderRadius: _borderRadius,
//             child: child),
//       ),
//     );
//   }

//   BorderRadius get _borderRadius => BorderRadius.circular(5);
// }


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';
import '../../domain/item/item.dart';

class ItemContainer extends ConsumerWidget {
  const ItemContainer({
    super.key,
    required this.width,
    required this.child,
    required this.item,
    this.attributionToken,
    this.isFrequencyItem = false,
  });

  final double width;
  final Widget child;
  final Item item;
  final String? attributionToken;
  final bool isFrequencyItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = BorderRadius.circular(12);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha:0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          splashColor: AppColors.primary.withValues(alpha:0.08),
          highlightColor: Colors.transparent,
          onTap: item.inStock == 0
              ? null
              : isFrequencyItem
                  ? () {
                      context.maybePop().then((value) {
                        context.pushRoute(ItemDetailsScreen(
                          itemId: item.websiteItemId,
                          mubadaraId: item.mubadaraId,
                        ));
                      });
                    }
                  : () => navigateToItemDetails(
                        context: context,
                        ref: ref,
                        itemId: item.websiteItemId,
                        itemType: item.websiteItemType,
                        isMubadara: item.isMubadara,
                        mubadaraId: item.mubadaraId,
                        attributionToken: attributionToken,
                      ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}