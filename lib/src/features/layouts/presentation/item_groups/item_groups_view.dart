import 'package:flutter/material.dart';
import '../../../layouts/domain/basic_item_group/basic_item_group.dart';
import 'grid_item_groups.dart';
import 'horizontal_grid_item_groups.dart';
import 'horizontal_list_item_groups.dart';

class ItemGroupsView extends StatelessWidget {
  const ItemGroupsView(
      {super.key,
      required this.itemGroups,
      required this.viewType,
      required this.backgroundColor,
      required this.showTitleBlock});
  final List<BasicItemGroup> itemGroups;
  final String viewType;
  final String? backgroundColor;
  final bool showTitleBlock;
  @override
  Widget build(BuildContext context) {
    if (viewType == 'Square') {
      return GridItemGroups(
          itemGroups: itemGroups,
          backgroundColor: backgroundColor!,
          showTitleBlock: showTitleBlock);
    }
    if (viewType == 'Circle') {
      return HorizontalGridItemGroups(
          itemGroups: itemGroups, backgroundColor: backgroundColor!);
    }
    return HorizontalListItemGroups(itemGroups: itemGroups);
  }
}
//       "block_id": "BLOCK-0064",
// I/flutter ( 5414):         "block_type": "Item",
// I/flutter ( 5414):         "title": "New Items",
// I/flutter ( 5414):         "view_type": "Square",
// I/flutter ( 5414):         "show_title": 1,
// I/flutter ( 5414):         "show_title_block": 1,
// I/flutter ( 5414):         "background": "#761ACB",
// I/flutter ( 5414):         "icon": null,
// I/flutter ( 5414):         "is_dynamic": 0,
// I/flutter ( 5414):         "filling_to_show": "",


// 
//   "block_id": "BLOCK-0005",
// I/flutter ( 5414):         "block_type": "Item Group",
// I/flutter ( 5414):         "title": "Meat Court",
// I/flutter ( 5414):         "show_title": 1,
// I/flutter ( 5414):         "show_title_block": 1,
// I/flutter ( 5414):         "background": "#ffece0",
// I/flutter ( 5414):         "item_group_background": "#F5866C",
// I/flutter ( 5414):         "icon": "https://widam.akwad.qa/files/MEAT COURT - EN.png",
// I/flutter ( 5414):         "view_type": "Square",



//    "block_id": "BLOCK-0040",
// I/flutter ( 5414):         "block_type": "Item Group",
// I/flutter ( 5414):         "title": "Featured Category",
// I/flutter ( 5414):         "show_title": 0,
// I/flutter ( 5414):         "show_title_block": 0,
// I/flutter ( 5414):         "background": "#ffffff",
// I/flutter ( 5414):         "item_group_background": "#FFFFFF",
// I/flutter ( 5414):         "icon": "https://widam.akwad.qa/files/Artboard 1 copy 10.png",
// I/flutter ( 5414):         "view_type": "Square",