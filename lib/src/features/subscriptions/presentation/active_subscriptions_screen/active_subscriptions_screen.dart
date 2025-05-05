import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/subscriptions/data/subscriptions_repository.dart';

import '../../../../common_widgets/app_thumb_item.dart';
import '../../../../common_widgets/titled_image.dart';
import '../../../../theme/app_colors.dart';

@RoutePage()
class ActiveSubscriptionsScreen extends StatelessWidget {
  const ActiveSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).activeSubscriptions)),
      body: const _ActiveSubscriptionsList(),
    );
  }
}

class _ActiveSubscriptionsList extends ConsumerWidget {
  const _ActiveSubscriptionsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSubscriptionsAsync = ref.watch(activeSubscriptionsProvider);
    return activeSubscriptionsAsync.when(
        data: (activeSubscriptions) {
          if (activeSubscriptions.isEmpty) {
            return Center(
                child: TitledImage(title: S.of(context).noActiveSubscriptions));
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                final items = activeSubscriptions[index].items;
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: const Offset(0, 0),
                            blurRadius: 2)
                      ]),
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activeSubscriptions[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          Assets.icons.loadingIcon.svg()
                        ]),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 70,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          return AppThumbItem(
                              quantity:
                                  items[index].quantity!.toInt().toString(),
                              image: items[index].image!);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10.0),
                        itemCount: items.length,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                          activeSubscriptions[index].interval.frequencyName,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.taupeGray)),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                          '${activeSubscriptions[index].intervalCount} ${activeSubscriptions[index].interval.frequencyName}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lapisBlue)),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                          '${S.of(context).endingOn} ${activeSubscriptions[index].endDate}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.taupeGray)),
                    ),
                  ]),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              padding: const EdgeInsets.all(10),
              itemCount: activeSubscriptions.length);
        },
        loading: () => const FadeCircleLoadingIndicator(),
        error: (error, stack) =>
            AppBanner(message: error.toString(), stackTrace: stack));
  }
}
