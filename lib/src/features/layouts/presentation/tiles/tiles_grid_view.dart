import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../../utils/utils.dart';

import '../../../layouts/domain/tile/tile.dart';

class TilesGridView extends ConsumerWidget {
  const TilesGridView({super.key, required this.tiles});
  final List<Tile> tiles;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 13,
          mainAxisSpacing: 10,
          childAspectRatio: 2.5),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              if (tiles[index].tileType == 'Website Item') {
                navigateToItemDetails(
                    context: context,
                    ref: ref,
                    itemId: tiles[index].tileLink,
                    itemType: tiles[index].websiteItemType);
              } else {
                ref
                    .read(paramsControllerProvider.notifier)
                    .set(tiles[index].parameters);
                pushItemGroupScreen(
                    context: context, itemGroupId: tiles[index].tileLink);
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: AppCachedNetworkImage(
                    imageUrl: tiles[index].tileImage, fit: BoxFit.fitWidth)));
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
    );
  }
}
