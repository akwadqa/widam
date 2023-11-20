import 'package:flutter/material.dart';

import '../../layouts/domain/block.dart';
import 'banner/banner_view.dart';
import 'item/item_view.dart';
import 'item_groups/item_groups_view.dart';
import 'tiles/tiles_grid_view.dart';

class BlockDataItem extends StatelessWidget {
  const BlockDataItem({super.key, required this.block});
  final Block block;
  @override
  Widget build(BuildContext context) {
    return switch (block.blockType) {
      'Banner' => BannerView(banners: block.data),
      'Item Group' => ItemGroupsView(
          showTitleBlock: block.showTitleBlock == 1,
          itemGroups: block.data,
          viewType: block.viewType!,
          backgroundColor: block.itemGroupBackground),
      'Item' || 'Mubadara' => ItemView(block: block),
      'Tile' => TilesGridView(tiles: block.data),
      _ => const Placeholder()
    };
  }
}
