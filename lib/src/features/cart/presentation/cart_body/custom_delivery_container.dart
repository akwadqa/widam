import 'package:flutter/cupertino.dart';
import '../../domain/cart/delivery_type.dart';
import '../items_container/items_container.dart';
import '../../../time_slots/presentation/time_slot_label.dart';
import 'cart_item/cart_item.dart';

class CustomDeliveryContainer extends StatelessWidget {
  const CustomDeliveryContainer(
      {super.key,
      required this.deliveryType,
      required this.currency,
      this.timeSlotWidget,
      required this.total,
      this.title, this.header});
  final DeliveryType deliveryType;
  final String currency;
  final Widget? timeSlotWidget;
  final double total;
  final String? title;
  final Widget? header;
  @override
  Widget build(BuildContext context) {
    return ItemsContainer(
      header: header,
        title: title ?? deliveryType.deliveryMethodTitle,
        timeSlotWidget: timeSlotWidget ??
            TimeSlotLabel(
              formattedDate: deliveryType.deliveryDate.dateFormatted,
              formattedTime: deliveryType.timeSlot.timeFormatted,
            ),
        content: Column(
            children: deliveryType.websiteItems
                .map((e) => CartItem(itemDetails: e))
                .toList()),
        subTotal: '${total.toStringAsFixed(2)} $currency',
        itemsCount: deliveryType.websiteItems.length.toString());
  }
}
