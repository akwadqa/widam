import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';

import '../../../../routing/app_router.gr.dart';
import '../../../layouts/domain/basic_item_group/basic_item_group.dart';

class HorizontalListItemGroups extends ConsumerWidget {
  const HorizontalListItemGroups({Key? key, required this.itemGroups})
      : super(key: key);
  final List<BasicItemGroup> itemGroups;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              ref
                  .read(paramsControllerProvider.notifier)
                  .set(itemGroups[index].parameters);
              context.pushRoute(ItemGroupScreen(itemGroupId: itemGroups[index].itemGroupId));
            },
            child: Container(
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      itemGroups[index].itemGroupImage),
                ),
              ),
            ),
          );
        },
        itemCount: itemGroups.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
