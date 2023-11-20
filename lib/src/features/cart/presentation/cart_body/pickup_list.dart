import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart_item/cart_item.dart';
import 'pickup_data.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../time_slots/presentation/time_slot_label.dart';
import '../../domain/cart/cart.dart';
import '../../domain/cart/pickup/pickup.dart';
import '../items_container/items_container.dart';

class PickupList extends StatelessWidget {
  const PickupList({super.key, required this.cart});
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Pickup pickup = cart.cartContent[index];
          return Padding(
            padding: EdgeInsets.only(top: index != 0 ? 20 : 0),
            child: ItemsContainer(
                title: pickup.timeSlotGroup,
                timeSlotWidget: Expanded(
                  child: TimeSlotLabel(
                    formattedDate: pickup.timeSlot.timeSlotId,
                    formattedTime: pickup.timeSlot.timeFormatted,
                  ),
                ),
                content: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PickupData(
                          title: pickup.pickupPointName,
                          description: pickup.address,
                          openingHours:
                              '${pickup.fromTime} - ${pickup.toTime}'),
                      Column(
                        children: [
                          Text(S.of(context).pickupLocation,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkBlue)),
                          const SizedBox(height: 2),
                          InkWell(
                              child: Assets.images.mapImage.image(),
                              onTap: () {
                                launchUrl(Uri.parse(pickup.location));
                              })
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  ...pickup.websiteItems.map((e) => CartItem(itemDetails: e))
                ]),
                subTotal:
                    '${pickup.subTotal} ${pickup.websiteItems.first.price.currency}}',
                itemsCount: pickup.websiteItems.length.toString()),
          );
        },
        childCount: cart.cartContent.length,
      ),
    );
  }
}
