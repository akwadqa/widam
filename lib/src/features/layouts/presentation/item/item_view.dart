import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/common_widgets/app_close_header.dart';
import 'package:widam/src/features/items/domain/item/item.dart';
import 'package:widam/src/features/layouts/presentation/item/dynamic_items_view.dart';
import 'package:widam/src/features/layouts/presentation/item/items_horizontal_list.dart';
import 'package:widam/src/features/layouts/presentation/item_groups/item_groups_bottom_sheet.dart';
import 'package:widam/src/routing/app_router.gr.dart';
import 'package:widam/src/theme/app_colors.dart';
import 'package:widam/src/utils/utils.dart';

import '../../../layouts/domain/block.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.block});
  final Block block;

  @override
  Widget build(BuildContext context) {
    if (block.isDynamic == 1) {
      return DynamicItemsView(
          blockId: block.blockId, fillingToShow: block.fillingToShow);
    }
    // return ItemsHorizontalList(
    //     items: block.data, attributionToken: block.attributionToken);

    // return ItemsHorizontalListItem(
    //         items: block.data,
    //         attributionToken: block.attributionToken,
    //       );
    switch (block.viewType) {
      case 'Square':
        return GridItemsView(
          items: block.data,
          backgroundColor: block.background,
          showTitleBlock: block.showTitleBlock == 1,
        );

      case 'Circle':
        return ItemsCircleHorizontalGrid(
          items: block.data,
          backgroundColor: block.background,
          attributionToken: block.attributionToken,
        );

      default:
        return ItemsHorizontalList(
          items: block.data,
          attributionToken: block.attributionToken,
        );
    }
  }
}

class GridItemsView extends StatelessWidget {
  const GridItemsView({
    super.key,
    required this.items,
    required this.backgroundColor,
    required this.showTitleBlock,
  });

  final List<Item> items;
  final String backgroundColor;
  final bool showTitleBlock;

  @override
  Widget build(BuildContext context) {
    final subList = items.take(11).toList();
    final showViewAll = items.length > 11;

    return GridView.builder(
      itemCount: showViewAll ? subList.length + 1 : subList.length,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: showTitleBlock ? 0.9 / 1.4 : 1,
      ),
      itemBuilder: (context, index) {
        final isAllCategory = showViewAll && index == subList.length;
        final item = isAllCategory ? null : subList[index];

        return ItemGridItem(
          item: isAllCategory ? null : item,
          isAllCategory: isAllCategory,
          backgroundColor: backgroundColor,
          showTitleBlock: showTitleBlock,
          onViewAllPressed: () {
            showAdaptiveModalBottomSheet(
              context: context,
              builder: (_) => ItemsBottomSheet(
                backgroundColor: backgroundColor,
                items: subList,
              ),
            );
          },
        );
      },
    );
  }
}

class ItemsCircleHorizontalGrid extends ConsumerWidget {
  const ItemsCircleHorizontalGrid({
    super.key,
    required this.items,
    required this.backgroundColor,
    this.attributionToken,
  });

  final List<Item> items;
  final String backgroundColor;
  final String? attributionToken;

  List<Item> _customOrder(List<Item> original) {
    if (original.length <= 6) {
      // less than or equal to 4 → all in first row
      return original;
    }

    List<Item> firstRow = [];
    List<Item> secondRow = [];

    // Step 1: Fill first row with exactly 4 items
    firstRow.addAll(original.take(5));

    // Step 2: Fill second row with remaining items up to 4
    int secondRowCount = (original.length - 4).clamp(0, 4);
    secondRow.addAll(original.skip(4).take(secondRowCount));

    // Step 3: If more than 8 items, alternate them
    List<Item> remaining = original.skip(8).toList();
    bool addToFirst = true;
    for (var item in remaining) {
      if (addToFirst) {
        firstRow.add(item);
      } else {
        secondRow.add(item);
      }
      addToFirst = !addToFirst;
    }

    // For horizontal GridView, we need to arrange items so first row appears on top
    // GridView fills column by column, so we interleave: first[0], second[0], first[1], second[1]...
    List<Item> reordered = [];
    int maxLen = math.max(firstRow.length, secondRow.length);
    for (int i = 0; i < maxLen; i++) {
      if (i < firstRow.length) {
        reordered.add(firstRow[i]);
      }
      if (i < secondRow.length) {
        reordered.add(secondRow[i]);
      }
    }

    return reordered;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- REORDER for row-first filling ---
    final int firstRowCount = (items.length / 2).ceil();
    List<Item> reordered = [];
    for (int i = 0; i < firstRowCount; i++) {
      reordered.add(items[i]);
      int secondRowIndex = i + firstRowCount;
      if (secondRowIndex < items.length) {
        reordered.add(items[secondRowIndex]);
      }
    }
    final reorderedItems = _customOrder(items);

    return SizedBox(
      height: 250,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 rows
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.3 / 1,
        ),
        itemCount: reordered.length,
        itemBuilder: (context, index) {
          // Re-map index so that first row fills first
          // int row = index % 2;
          // int col = index ~/ 2;
          // int mappedIndex = row * columns + col;

          // if (mappedIndex >= items.length) return const SizedBox();

          // final item = items[mappedIndex];
          final item = reordered[index];

          return InkWell(
            onTap: () {
              navigateToItemDetails(
                context: context,
                ref: ref,
                itemId: item.websiteItemId,
                itemType: item.websiteItemType,
                isMubadara: item.isMubadara,
                mubadaraId: item.mubadaraId,
                attributionToken: attributionToken,
              );
            },
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: AppColors.hexToColor(backgroundColor),
                    child: ClipOval(
                      child: AppCachedNetworkImage(
                        imageUrl: item.websiteItemImage??"",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: 2,
                  child: Text(
                    item.websiteItemShortName ?? item.websiteItemName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.raisinBlack,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ItemGridItem extends ConsumerWidget {
  const ItemGridItem({
    super.key,
    required this.item,
    required this.isAllCategory,
    required this.backgroundColor,
    required this.showTitleBlock,
    this.insideBottomSheet,
    required this.onViewAllPressed,
  });

  final Item? item;
  final bool isAllCategory;
  final bool? insideBottomSheet;
  final String backgroundColor;
  final bool showTitleBlock;
  final VoidCallback? onViewAllPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget content = isAllCategory
        ? const Center(child: Icon(Icons.grid_view, size: 40))
        : AppCachedNetworkImage(imageUrl: item!.websiteItemImage??"");

    return Column(
      children: [
        Expanded(
          flex: 7,
          child: InkWell(
            onTap: () {
              if (isAllCategory) {
                debugPrint("onViewAllPressed");
                onViewAllPressed?.call();
              } else {
                navigateToItemDetails(
                  context: context,
                  ref: ref,
                  itemId: item!.websiteItemId,
                  itemType:
                      insideBottomSheet != null ? "V" : item!.websiteItemType,
                  isMubadara: item!.isMubadara,
                  mubadaraId: item!.mubadaraId,
                  attributionToken: null,
                );
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.aliceBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: content,
              ),
            ),
          ),
        ),
        if (showTitleBlock)
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                isAllCategory
                    ? "View All"
                    :  item?.websiteItemShortName??item!.websiteItemName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.raisinBlack),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
      ],
    );
  }
}

class ItemsHorizontalListItem extends ConsumerWidget {
  const ItemsHorizontalListItem({
    super.key,
    required this.items,
    this.attributionToken,
    this.height = 200,
    this.itemWidth = 140,
  });

  final List<Item> items;
  final String? attributionToken;
  final double height;
  final double itemWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              navigateToItemDetails(
                context: context,
                ref: ref,
                itemId: item.websiteItemId,
                itemType: item.websiteItemType,
                isMubadara: item.isMubadara,
                mubadaraId: item.mubadaraId,
                attributionToken: attributionToken,
              );
            },
            child: Container(
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.websiteItemImage??""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemsBottomSheet extends StatelessWidget {
  const ItemsBottomSheet({
    super.key,
    required this.backgroundColor,
    required this.items,
  });

  final String backgroundColor;
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AppCloseHeader(
        withDivider: false,
        title: S.of(context).items,
        content: _Content(
          backgroundColor: backgroundColor,
          items: items,
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.backgroundColor,
    required this.items,
  });

  final String backgroundColor;
  final List<Item> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemGridItem(
            item: items[index],
            isAllCategory: false,
            backgroundColor: backgroundColor,
            showTitleBlock: true,
            insideBottomSheet: true,
            onViewAllPressed: null, // not used when isAllCategory == false
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 20,
          childAspectRatio: 0.9 / 1.3,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
