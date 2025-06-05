import 'package:flutter/material.dart';
import 'package:widam/src/features/cart/presentation/cart_body/cart_container.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class ItemsContainer extends StatelessWidget {
  const ItemsContainer(
      {super.key,
      required this.title,
      required this.timeSlotWidget,
      required this.content,
      required this.subTotal,
      required this.itemsCount,
      this.header});
  final String title;
  final Widget timeSlotWidget;
  final Widget content;
  final String subTotal;
  final String itemsCount;
  final Widget? header;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CartContainer(
          child: Column(children: [
            if (header != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: header!,
              ),
            ],
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // width: 70,
                  child: Text(title,
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,child: timeSlotWidget)
              ],
            ),
            const Divider(),
            content,
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).subTotal,
                    style: const TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                Text(subTotal,
                    style: const TextStyle(
                        color: AppColors.taupeGray,
                        fontSize: 12,
                        fontWeight: FontWeight.w500))
              ],
            )
          ]),
        ),
        PositionedDirectional(
            top: -8,
            start: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: const BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Text('$itemsCount ${S.of(context).item}',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ))
      ],
    );
  }
}
