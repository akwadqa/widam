import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../items/domain/item/item.dart';
import 'deals_item.dart';
import 'deals_leading_item.dart';

class DealsGrid extends StatelessWidget {
  const DealsGrid({Key? key, required this.items}) : super(key: key);
  final List<Item> items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(
            items.length,
            (index) => StaggeredGridTile.count(
                  crossAxisCellCount: index % 4 == 0 ? 3 : 1,
                  mainAxisCellCount: index % 4 == 0 ? 1.2 : 2.1,
                  child: index % 4 == 0
                      ? DealsLeadingItem(item: items[index])
                      : DealsItem(item: items[index]),
                )),
      ),
    );
  }
}
