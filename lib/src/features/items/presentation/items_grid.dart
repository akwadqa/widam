import 'package:flutter/material.dart';
import 'package:widam/src/features/items/domain/item/item.dart';
import 'package:widam/src/features/items/presentation/item_card/item_card.dart';

class ItemsGrid extends StatelessWidget {
  const ItemsGrid({
    super.key,
    required this.items,
    this.childAspectRatio = 0.67,
  });

  final List<Item> items;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsetsDirectional.only(
          start: 8.0, bottom: 8.0, end: 10.0),
      itemBuilder: (context, index) {
        return ItemCard(item: items[index]);
      },
    );
  }
}