import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'subscription_item_card.dart';
import 'subscription_items_notifier.dart';

import '../../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../../../common_widgets/fade_circle_loading_indicator.dart';

class SubscriptionItemsList extends ConsumerWidget {
  const SubscriptionItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(subscriptionsItemsNotifierProvider, (previous, next) {
      if (next is SubscriptionsItemsLoaded && next.paginationError != null) {
        showAppBannerDialog(context, next.paginationError!.error.toString(),
            next.paginationError?.stackTrace);
      }
    });
    final state = ref.watch(subscriptionsItemsNotifierProvider);
    if (state is SubscriptionsItemsLoading) {
      return const SliverToBoxAdapter(child: FadeCircleLoadingIndicator());
    } else if (state is SubscriptionsItemsError) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: AppBanner(
              message: state.error.toString(), stackTrace: state.stackTrace),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                SubscriptionItemCard(item: state.items[index]),
                const SizedBox(height: 8.0),
              ],
            );
          },
          childCount: (state as SubscriptionsItemsLoaded).items.length,
        ),
      ),
    );
  }
}
