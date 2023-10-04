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
      this.focusNode,
      required this.total});
  final DeliveryType deliveryType;
  final String currency;
  final Widget? timeSlotWidget;
  final FocusNode? focusNode;
  final String total;
  @override
  Widget build(BuildContext context) {
    return ItemsContainer(
        title: deliveryType.deliveryMethodTitle,
        timeSlotWidget: Focus(
            focusNode: focusNode,
            child: timeSlotWidget ??
                TimeSlotLabel(
                  formattedDate: deliveryType.deliveryDate.dateFormatted,
                  formattedTime: deliveryType.timeSlot.timeFormatted,
                )),
        content: Column(
            children: deliveryType.websiteItems
                .map((e) => CartItem(itemDetails: e))
                .toList()),
        subTotal: '$total $currency',
        itemsCount: deliveryType.websiteItems.length.toString());
  }
}
