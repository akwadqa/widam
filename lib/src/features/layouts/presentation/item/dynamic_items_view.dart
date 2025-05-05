import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/layouts_repository.dart';
import 'deals_grid.dart';
import 'empty_widget.dart';
import 'items_horizontal_list.dart';

class DynamicItemsView extends ConsumerWidget {
  const DynamicItemsView(
      {super.key, required this.blockId, required this.fillingToShow});
  final String blockId;
  final String? fillingToShow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final block = ref.watch(blockProvider(blockId: blockId));
    return block.when(
        data: (block) => fillingToShow == 'Deals of the Day'
            ? DealsGrid(items: block.data)
            : ItemsHorizontalList(
                items: block.data, attributionToken: block.attributionToken),
        error: (error, stackTrace) =>
            EmptyWidget(message: error.toString(), stackTrace: stackTrace),
        loading: () => const EmptyWidget());
  }
}
