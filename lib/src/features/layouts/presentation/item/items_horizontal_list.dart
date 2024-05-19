import 'package:flutter/material.dart';
import '../../../items/presentation/item_card/item_card.dart';
import '../../../items/domain/item/item.dart';

class ItemsHorizontalList extends StatelessWidget {
  const ItemsHorizontalList(
      {super.key,
      required this.items,
      this.padding = const EdgeInsets.symmetric(horizontal: 10),
      this.attributionToken});
  final List<Item> items;
  final String? attributionToken;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          const double width = 200;
          return ItemCard(
              item: items[index],
              attributionToken: attributionToken,
              width: width);
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
