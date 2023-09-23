import 'package:flutter/material.dart';
import '../../../layouts/domain/basic_item_group/basic_item_group.dart';
import 'grid_item_groups.dart';
import 'horizontal_grid_item_groups.dart';
import 'horizontal_list_item_groups.dart';

class ItemGroupsView extends StatelessWidget {
  const ItemGroupsView(
      {Key? key,
      required this.itemGroups,
      required this.viewType,
      required this.backgroundColor})
      : super(key: key);
  final List<BasicItemGroup> itemGroups;
  final String viewType;
  final String? backgroundColor;
  @override
  Widget build(BuildContext context) {
    if (viewType == 'Square') {
      return GridItemGroups(
          itemGroups: itemGroups, backgroundColor: backgroundColor!);
    }
    if (viewType == 'Circle') {
      return HorizontalGridItemGroups(
          itemGroups: itemGroups, backgroundColor: backgroundColor!);
    }
    return HorizontalListItemGroups(itemGroups: itemGroups);
  }
}
