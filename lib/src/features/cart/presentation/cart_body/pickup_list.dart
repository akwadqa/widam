import 'package:flutter/material.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/constants/services_urls.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
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
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: AppCachedNetworkImage(
                                  imageUrl:
                                      '${ServicesUrls.googleMapsBaseUrl}/staticmap?size=${600}x${400}&visible=${pickup.coordinates.latitude},${pickup.coordinates.longitude}&zoom=${18}&key=${Keys.googleAPIKey}&language=${Directionality.of(context) == TextDirection.ltr ? 'en' : 'ar'}')),
                        ],
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
