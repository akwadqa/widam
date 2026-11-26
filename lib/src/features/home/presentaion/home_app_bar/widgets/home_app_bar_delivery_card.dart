import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/app_shimmer.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../../../addresses/presentation/maps/address_selector_button/address_selector_button.dart';
import '../../../../addresses/presentation/maps/address_selector_button/address_selector_button_controller.dart';
import '../../../../time_slots/presentation/time_slot_controller.dart';
import '../../utils/home_date_formatter.dart';
import '../../utils/home_decorations.dart';
import '../../widgets/home_icon_tile.dart';

/// Frosted card at the top of the home page: earliest delivery slot on one
/// side, the delivery address picker on the other.
class HomeAppBarDeliveryCard extends StatelessWidget {
  const HomeAppBarDeliveryCard({super.key});

  static const double _radius = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HomeDecorations.frostedWhite,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: HomeDecorations.whiteBorder),
        boxShadow: HomeDecorations.headerCardShadow,
      ),
      child: const IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _EarliestDeliverySlot()),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.paleSkyBlue,
              ),
            ),
            _DeliveryAddressButton(radius: _radius),
          ],
        ),
      ),
    );
  }
}

class _EarliestDeliverySlot extends ConsumerWidget {
  const _EarliestDeliverySlot();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slot = ref.watch(timeSlotControllerProvider);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final title = S.of(context).homeEarliestDelivery;
    final label = slot.formattedDate.isEmpty
        ? title
        : '$title · ${HomeDateFormatter.shortDeliveryDate(slot.formattedDate, isRtl: isRtl)}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const HomeIconTile(
            icon: Icons.local_shipping_outlined,
            size: 38,
            iconSize: 20,
            radius: 12,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium11
                      .copyWith(color: HomeDecorations.mutedText),
                ),
                slot.formattedTime.isEmpty
                    ? const _TextSkeleton(width: 110)
                    : Text(
                        slot.formattedTime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bold16
                            .copyWith(color: AppColors.navyBlue),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryAddressButton extends ConsumerWidget {
  const _DeliveryAddressButton({required this.radius});

  final double radius;

  static const double _maxWidth = 140;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressName = ref.watch(
        addressSelectorButtonControllerProvider.select((name) => name.value));

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => showAddressSelector(context, ref),
        borderRadius: BorderRadiusDirectional.horizontal(
          end: Radius.circular(radius),
        ).resolve(Directionality.of(context)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).homeDeliverTo,
                  maxLines: 1,
                  style: AppTextStyles.medium11
                      .copyWith(color: HomeDecorations.mutedText),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: addressName == null || addressName.isEmpty
                          ? const _TextSkeleton(width: 60)
                          : Text(
                              addressName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bold15
                                  .copyWith(color: AppColors.navyBlue),
                            ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 18,
                      color: AppColors.navyBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shimmering placeholder shown while the slot or the address is loading.
class _TextSkeleton extends StatelessWidget {
  const _TextSkeleton({required this.width});

  final double width;

  static const double _height = 14;
  static const double _verticalMargin = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalMargin),
      child: AppShimmer(
        child: AppSkeletonBox(width: width, height: _height),
      ),
    );
  }
}
