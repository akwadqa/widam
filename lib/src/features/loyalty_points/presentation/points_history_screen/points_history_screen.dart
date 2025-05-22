import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/loyalty_points/domain/loyalty_points_log/loyalty_points_log.dart';
import 'package:widam/src/features/loyalty_points/presentation/points_history_screen/points_history_controller.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../../../common_widgets/app_pagination_widget.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../theme/app_theme.dart';

@RoutePage()
class PointsHistoryScreen extends ConsumerWidget {
  const PointsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsHistoryAsync = ref.watch(pointsHistoryControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).pointsHistory)),
      body: pointsHistoryAsync.when(
          data: (pointsHistory) {
            return AppPaginationWidget(
              onLoading:
                  ref.read(pointsHistoryControllerProvider.notifier).onLoading,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return _PointsHistoryItem(
                        loyaltyPointsLog: pointsHistory.data[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  padding: const EdgeInsets.all(10),
                  itemCount: pointsHistory.data.length),
            );
          },
          error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppBanner(
                    message: error.toString(), stackTrace: stackTrace),
              ),
          loading: () => const Center(child: FadeCircleLoadingIndicator())),
    );
  }
}

class _PointsHistoryItem extends StatelessWidget {
  const _PointsHistoryItem({required this.loyaltyPointsLog});
  final LoyaltyPointsLog loyaltyPointsLog;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: AppColors.brightGray, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 2,
              offset: const Offset(0, 0),
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final fontFamily = ref.watch(fontFamilyProvider);
                return RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: fontFamily,
                        color: AppColors.londonRain),
                    children: [
                      TextSpan(
                        text: loyaltyPointsLog.invoiceType == 'Sales Invoice'
                            ? S.of(context).salesInvoice
                            : S.of(context).loyaltyPointsRedeem,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' ${loyaltyPointsLog.invoice}',
                      ),
                    ],
                  ),
                );
              },
            ),
            Text(loyaltyPointsLog.loyaltyPoints.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.londonRain))
          ],
        ),
        const SizedBox(height: 8),
        Text(loyaltyPointsLog.postingDate,
            style: const TextStyle(
                color: AppColors.gray, fontWeight: FontWeight.w500))
      ]),
    );
  }
}
