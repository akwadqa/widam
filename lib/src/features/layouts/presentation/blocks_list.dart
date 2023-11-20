import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/banner/app_banner.dart';

import '../../../common_widgets/fade_circle_loading_indicator.dart';
import '../data/layouts_repository.dart';
import 'block_item.dart';

class BlocksList extends ConsumerWidget {
  const BlocksList({super.key, required this.layoutType});
  final LayoutType layoutType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider(layoutType));
    return layout.when(
        data: (layout) {
          return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            final block = layout.data[index];
            return BlockItem(block: block);
          }, childCount: layout.data.length));
        },
        error: (error, stack) => SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppBanner(message: error.toString(), stackTrace: stack),
            )),
        loading: () => const SliverFillRemaining(
            hasScrollBody: false, child: FadeCircleLoadingIndicator()));
  }
}
