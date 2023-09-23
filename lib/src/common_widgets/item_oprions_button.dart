import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gen/assets.gen.dart';
import '../features/items/domain/item/item.dart';
import '../features/items/presentation/item_card/circle_button.dart';
import '../utils/utils.dart';

class ItemOprionsButton extends ConsumerWidget {
  const ItemOprionsButton({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleButton(
      onTap: () => navigateToItemDetails(
          context: context,
          ref: ref,
          itemId: item.websiteItemId,
          itemType: item.websiteItemType,
          isMubadara: item.isMubadara,
          mubadaraId: item.mubadaraId,
          hasProductOptions: item.hasProductOptions),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Assets.icons.optionsIcon.svg(),
      ),
    );
  }
}
