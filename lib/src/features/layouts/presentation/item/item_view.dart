import 'package:flutter/material.dart';

import '../../../layouts/domain/block.dart';
import 'dynamic_items_view.dart';
import 'items_horizontal_list.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.block});
  final Block block;
  @override
  Widget build(BuildContext context) {
    if (block.isDynamic == 1) {
      return DynamicItemsView(
          blockId: block.blockId, fillingToShow: block.fillingToShow);
    }
    return ItemsHorizontalList(
        items: block.data, attributionToken: block.attributionToken);
  }
}
