import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../routing/app_router.gr.dart';
import '../../../../../common_widgets/app_shimmer.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../utils/home_decorations.dart';
import '../../utils/home_order_status.dart';
import '../../widgets/home_icon_tile.dart';
import '../home_order_tracking_controller.dart';

/// Card under the header showing the user's order in progress with its
/// status steps. Shows a shimmer skeleton while loading, and nothing when
/// there is no order in progress. Size changes animate so the content below
/// slides instead of jumping.
class HomeBodyOrderTrackingCard extends ConsumerWidget {
  const HomeBodyOrderTrackingCard({super.key});

  static const Duration _animationDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracking = ref.watch(homeOrderTrackingControllerProvider);
    final value = tracking.value;
    final Widget child = value != null
        ? _OrderTrackingContent(tracking: value)
        : tracking.isLoading
            ? const _OrderTrackingSkeleton()
            : const SizedBox(width: double.infinity);

    return AnimatedSize(
      duration: _animationDuration,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: _animationDuration,
        child: child,
      ),
    );
  }
}

/// White rounded card shared by the content and its skeleton.
class _CardFrame extends StatelessWidget {
  const _CardFrame({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  static const double _radius = 24;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_radius);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border.all(color: AppColors.solitudeBlue),
          boxShadow: HomeDecorations.contentCardShadow,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderTrackingContent extends StatelessWidget {
  const _OrderTrackingContent({required this.tracking});

  final HomeOrderTracking tracking;

  /// Tab of `SalesOrdersScreen` that lists the open orders.
  static const int _openOrdersTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    final activeOrder = tracking.activeOrder;
    return _CardFrame(
      onTap: () => context
          .pushRoute(SalesOrdersScreen(initialIndex: _openOrdersTabIndex)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _OrderSummary(activeOrder: activeOrder),
          if (activeOrder != null) ...[
            const SizedBox(height: _stepsSpacing),
            _OrderSteps(activeOrder: activeOrder),
          ],
        ],
      ),
    );
  }
}

const double _stepsSpacing = 14;
const double _iconTileSize = 42;
const int _skeletonStepsCount = 4;
const double _stepSpacing = 4;

/// Same layout as the loaded card: icon, two text lines, track pill, steps.
class _OrderTrackingSkeleton extends StatelessWidget {
  const _OrderTrackingSkeleton();

  @override
  Widget build(BuildContext context) {
    return _CardFrame(
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SkeletonSummary(),
            const SizedBox(height: _stepsSpacing),
            Row(
              children: [
                for (var index = 0; index < _skeletonStepsCount; index++) ...[
                  if (index > 0) const SizedBox(width: _stepSpacing),
                  const Expanded(child: _SkeletonStep()),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonSummary extends StatelessWidget {
  const _SkeletonSummary();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        AppSkeletonBox(width: _iconTileSize, height: _iconTileSize, radius: 14),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSkeletonBox(width: 140, height: 14),
              SizedBox(height: 8),
              AppSkeletonBox(width: 190, height: 10),
              SizedBox(height: 6),
              AppSkeletonBox(width: 90, height: 10),
            ],
          ),
        ),
        SizedBox(width: 8),
        AppSkeletonBox(width: 64, height: 32),
      ],
    );
  }
}

class _SkeletonStep extends StatelessWidget {
  const _SkeletonStep();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSkeletonBox(height: 5),
        SizedBox(height: 6),
        AppSkeletonBox(width: 48, height: 10),
      ],
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.activeOrder});

  /// `null` → generic "orders in progress" text without order details.
  final HomeActiveOrder? activeOrder;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final order = activeOrder?.order;
    final title = order == null
        ? s.pendingOrderTitle
        : _title(s, HomeOrderStatus.fromApiValue(order.status));
    final subtitle = order == null
        ? s.pendingOrderDescription
        : '${s.order} ${order.salesOrderId} · ${s.homeOrderArrives} '
            '${order.deliveryDate.dateFormatted} ${order.time}';

    return Row(
      children: [
        const HomeIconTile(
          icon: Icons.local_shipping_outlined,
          size: _iconTileSize,
          iconSize: 22,
          radius: 14,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bold15.copyWith(color: AppColors.navyBlue),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium12
                    .copyWith(color: HomeDecorations.mutedText),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const _TrackPill(),
      ],
    );
  }

  String _title(S s, HomeOrderStatus? status) => switch (status) {
        HomeOrderStatus.submitted => s.homeOrderTitlePlaced,
        HomeOrderStatus.loaded => s.homeOrderTitlePreparing,
        HomeOrderStatus.onTheWay => s.homeOrderTitleOnTheWay,
        HomeOrderStatus.delivered => s.homeOrderTitleDelivered,
        null => s.pendingOrderTitle,
      };
}

class _TrackPill extends StatelessWidget {
  const _TrackPill();

  static const double _height = 32;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(_height / 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).homeTrack,
            style: AppTextStyles.bold12.copyWith(color: Colors.white),
          ),
          const SizedBox(width: 4),
          // Mirrors with the text direction, so it points forward.
          const Icon(Icons.chevron_right, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}

/// One bar + label per API status: done steps in light blue, the current
/// step in navy, the remaining steps greyed out.
class _OrderSteps extends StatelessWidget {
  const _OrderSteps({required this.activeOrder});

  final HomeActiveOrder activeOrder;

  @override
  Widget build(BuildContext context) {
    final statuses = activeOrder.statuses;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < statuses.length; index++) ...[
          if (index > 0) const SizedBox(width: _stepSpacing),
          Expanded(
            child: _OrderStep(
              label: _label(S.of(context), statuses[index]),
              state: _stepState(index),
            ),
          ),
        ],
      ],
    );
  }

  _StepState _stepState(int index) {
    if (index < activeOrder.currentStep) return _StepState.done;
    if (index == activeOrder.currentStep) return _StepState.current;
    return _StepState.upcoming;
  }

  String _label(S s, String apiStatus) =>
      switch (HomeOrderStatus.fromApiValue(apiStatus)) {
        HomeOrderStatus.submitted => s.homeOrderStepPlaced,
        HomeOrderStatus.loaded => s.homeOrderStepPreparing,
        HomeOrderStatus.onTheWay => s.homeOrderStepOnTheWay,
        HomeOrderStatus.delivered => s.homeOrderStepDelivered,
        null => apiStatus,
      };
}

enum _StepState { done, current, upcoming }

class _OrderStep extends StatelessWidget {
  const _OrderStep({required this.label, required this.state});

  final String label;
  final _StepState state;

  static const double _barHeight = 5;

  @override
  Widget build(BuildContext context) {
    final (barColor, textColor, weight) = switch (state) {
      _StepState.done => (
          AppColors.vividCerulean,
          AppColors.navyBlue,
          FontWeight.w500
        ),
      _StepState.current => (
          AppColors.navyBlue,
          AppColors.navyBlue,
          FontWeight.w700
        ),
      _StepState.upcoming => (
          AppColors.linkWater,
          AppColors.slateGray,
          FontWeight.w500
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: _barHeight,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(_barHeight / 2),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.medium11
              .copyWith(color: textColor, fontWeight: weight),
        ),
      ],
    );
  }
}
