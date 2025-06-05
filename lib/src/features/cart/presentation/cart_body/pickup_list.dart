import 'package:flutter/material.dart';
import 'package:widam/src/features/cart/presentation/cart_body/pickup_image.dart';
import 'cart_item/cart_item.dart';
import 'pickup_data.dart';
import '../../../../theme/app_colors.dart';

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
                timeSlotWidget: TimeSlotLabel(
                  formattedDate: pickup.deliveryDate.dateFormatted,
                  formattedTime: pickup.timeSlot.timeFormatted,
                  customeTitle: S.of(context).pickupTimeSlot,
                ),
                content: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: PickupData(
                            title: pickup.pickupPointName,
                            description: pickup.address,
                            openingHours: pickup.timeSlot.timeFormatted),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Column(
                          children: [
                            Text(S.of(context).pickupLocation,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBlue)),
                            const SizedBox(height: 2),
                            PickupMapImage(
                              latitude: pickup.coordinates.latitude,
                              longitude: pickup.coordinates.longitude,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  ...pickup.websiteItems.map((e) => CartItem(itemDetails: e))
                ]),
                subTotal:
                    '${pickup.subTotal} ${pickup.websiteItems.first.price.currency}',
                itemsCount: pickup.websiteItems.length.toString()),
          );
        },
        childCount: cart.cartContent.length,
      ),
    );
  }
}
