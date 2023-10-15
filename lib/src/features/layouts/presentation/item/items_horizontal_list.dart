import 'package:flutter/material.dart';
import '../../../items/presentation/item_card/item_card.dart';
import '../../../items/domain/item/item.dart';
import 'mubadara_item.dart';

class ItemsHorizontalList extends StatelessWidget {
  const ItemsHorizontalList(
      {Key? key,
      required this.items,
      this.padding = const EdgeInsets.symmetric(horizontal: 10),
      this.attributionToken})
      : super(key: key);
  final List<Item> items;
  final String? attributionToken;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return items[index].isMubadara == 1
              ? MubadaraItem(
                  item: items[index], attributionToken: attributionToken)
              : ItemCard(
                  item: items[index], attributionToken: attributionToken);
        },
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        padding: padding,
      ),
    );
  }
}
