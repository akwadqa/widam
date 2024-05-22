import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../common_widgets/app_thumb_item.dart';
import '../../../../utils/utils.dart';
import '../../../cart/application/cart_service.dart';
import '../../../cart/domain/cart/delivery_type.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../generated/l10n.dart';
import '../../../time_slots/domain/geofence_details/time_slot.dart';
import '../../../time_slots/presentation/time_slots_selector/time_slots_selector.dart';

class DeliveryContainer extends StatelessWidget {
  const DeliveryContainer(
      {super.key,
      required this.deliveryType,
      required this.currency,
      this.isPickup});
  final DeliveryType deliveryType;
  final String currency;
  final bool? isPickup;

  @override
  Widget build(BuildContext context) {
    print('deliveryMethodId = ${deliveryType.deliveryMethodId}');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.brightGray, width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(children: [
        Row(
          children: [
            Assets.icons.truckTimeIcon.svg(),
            const SizedBox(width: 8.0),
            Text(deliveryType.deliveryMethodTitle,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return AppThumbItem(
                  quantity: deliveryType.websiteItems[index].qtyInCart!
                      .toInt()
                      .toString(),
                  image: deliveryType
                      .websiteItems[index].additionalImages.first.image);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10.0),
            itemCount: deliveryType.websiteItems.length,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).deliverySlot, style: _titleTextStyle()),
            Consumer(
              builder: (context, ref, child) {
                return TextButton(
                  onPressed: () {
                    showAdaptiveModalBottomSheet<
                            ({TimeSlot timeSlot, String deliveryDate})?>(
                        context: context,
                        builder: (ctx) {
                          return TimeSlotsSelector(
                              deleiveryMethodId: deliveryType.deliveryMethodId,
                              initialDate: deliveryType.deliveryDate.date,
                              initialTimeSlot: deliveryType.timeSlot);
                        }).then((value) {
                      if (value != null) {
                        ref.read(updateCartProvider.notifier).updateCart(
                            pickupPointId: isPickup == true
                                ? deliveryType.deliveryMethodId
                                : null,
                            timeSlot: value.timeSlot.timeSlotId,
                            deliveryDate: value.deliveryDate);
                      }
                    });
                  },
                  style:
                      TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          '${deliveryType.deliveryDate.dateFormatted.split(', ').last}, ${deliveryType.timeSlot.timeFormatted}',
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: AppColors.londonRain,
                              fontWeight: FontWeight.w600)),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        if (isPickup != true)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).deliveryFee, style: _titleTextStyle()),
              Text(
                  '${deliveryType.deliveryCharges.toStringAsFixed(2)} $currency',
                  style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600))
            ],
          )
      ]),
    );
  }

  TextStyle _titleTextStyle() {
    return const TextStyle(
        fontSize: 13.0, color: Colors.black, fontWeight: FontWeight.w500);
  }
}
