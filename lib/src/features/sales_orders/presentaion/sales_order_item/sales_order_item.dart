import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/constants/images.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart';
import 'package:widam/src/features/sales_orders/presentaion/reorder_button/reorder_button.dart';
import 'package:widam/src/features/sales_orders/presentaion/reorder_button/reorder_controller.dart';
import 'package:widam/src/routing/app_router.gr.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../../../common_widgets/app_thumb_item.dart';
import '../../../../theme/app_theme.dart';

enum SalesOrderType { open, past }

class SalesOrderItem extends StatelessWidget {
  const SalesOrderItem(
      {super.key,
      required this.salesOrder,
      required this.statuses,
      required this.salesOrderType});
  final SalesOrder salesOrder;
  final List<String> statuses;
  final SalesOrderType salesOrderType;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(2),
      onTap: salesOrderType == SalesOrderType.open
          ? null
          : () => context.pushRoute(SalesOrderDetailsScreen(
              salesOrder: salesOrder, statuses: statuses)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 2,
                offset: const Offset(0, 0),
              )
            ]),
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final fontFamily = ref.watch(fontFamilyProvider);
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${S.of(context).order} ',
                              style: TextStyle(
                                  color: AppColors.silver,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontFamily),
                            ),
                            TextSpan(
                              text: salesOrder.salesOrderId,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Text('${salesOrder.salesOrderDate} . ${salesOrder.time}',
                      style: const TextStyle(
                        color: AppColors.silver,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cultured,
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(_getTranslatedStatus(salesOrder.status, context),
                    style: const TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              )
            ],
          ),
          const SizedBox(height: 18),
          if (salesOrderType == SalesOrderType.open) ...[
            Stepper(
              currentStep: statuses
                  .indexWhere((element) => element == salesOrder.status),
              steps: statuses
                  .map((e) => _getStepByStatus(e, salesOrder, context))
                  .toList(),
              controlsBuilder: (context, details) {
                return Container();
              },
              physics: const NeverScrollableScrollPhysics(),
              stepIconBuilder: (stepIndex, stepState) =>
                  stepState == StepState.disabled
                      ? Container(
                          width: 30,
                          height: 30,
                          color: Colors.white,
                          child: DottedBorder(
                            borderType: BorderType.Circle,
                            strokeCap: StrokeCap.round,
                            dashPattern: const [4, 2],
                            strokeWidth: 0.5,
                            color: AppColors.spanishGray,
                            child: const _StepperIcon(
                                backgroundColor: AppColors.spanishGray),
                          ),
                        )
                      : Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.darkBlue,
                              width: 0.5,
                            ),
                          ),
                          child: const _StepperIcon(),
                        ),
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                return AppThumbItem(
                    quantity:
                        salesOrder.items[index].quantity.toInt().toString(),
                    image: salesOrder.items[index].imageView);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10.0),
              itemCount: salesOrder.items.length,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${salesOrder.currency} ${salesOrder.grandTotal}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Assets.icons.clockIcon.svg(
                          colorFilter: const ColorFilter.mode(
                              AppColors.secondary, BlendMode.srcIn),
                          height: 20),
                      const SizedBox(width: 4),
                      Text(
                          salesOrder.deliveryCharges.first.deliveryMethodTitle!,
                          style: const TextStyle(
                            color: AppColors.gray,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  )
                ],
              ),
              if (salesOrderType == SalesOrderType.past)
                ProviderScope(overrides: [
                  reorderControllerProvider
                      .overrideWith(() => ReorderController())
                ], child: ReorderButton(salesOrderId: salesOrder.salesOrderId))
            ],
          )
        ]),
      ),
    );
  }

  Step _getStepByStatus(
      String status, SalesOrder salesOrder, BuildContext context) {
    return switch (status) {
      'Submitted' => _step(
          title: Text(_getTranslatedStatus(status, context)),
          subtitle: Text('${S.of(context).on} ${salesOrder.salesOrderDate}'),
          content: const SizedBox.shrink(),
          status: status),
      'Loaded' => _step(
          title: Text(S.of(context).packageIsLoaded),
          subtitle: Text(S.of(context).driverIsOutForDelivery),
          content: const SizedBox.shrink(),
          status: status),
      'On the way' => _step(
          title: Text(S.of(context).driverIsOnTheWay),
          subtitle: Text(S.of(context).theOrderIsNearlyWithYou),
          content: salesOrder.deliveryTrip == null
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final fontFamily = ref.watch(fontFamilyProvider);
                        return TextButton(
                            onPressed: () {
                              final contactNumber =
                                  salesOrder.deliveryTrip?.driverCellNumber;
                              if (contactNumber != null) {
                                final Uri telLaunchUri = Uri(
                                  scheme: 'tel',
                                  path: contactNumber,
                                );
                                launchUrl(telLaunchUri);
                              }
                            },
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(AppColors.darkBlue),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  fontFamily: fontFamily)),
                            ),
                            child: Text(S.of(context).contactDriver));
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AppCachedNetworkImage(
                          imageUrl:
                              'https://maps.googleapis.com/maps/api/staticmap?size=640x260&markers=anchor:30,40|${Images.customerMarker}|${salesOrder.address.latitude},${salesOrder.address.longitude}&markers=anchor:10,10|icon:https://widam.akwad.qa/files/drivers-marker.png|${salesOrder.deliveryTrip!.driverAddress.latitude},${salesOrder.deliveryTrip!.driverAddress.longitude}&path=color:0055BB|weight:2|${salesOrder.address.latitude},${salesOrder.address.longitude}|${salesOrder.deliveryTrip!.driverAddress.latitude},${salesOrder.deliveryTrip!.driverAddress.longitude}&key=${Keys.googleAPIKey}&scale=1&language=${Directionality.of(context) == TextDirection.ltr ? 'en' : 'ar'}'),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: SubmitButton(
                            text: S.of(context).trackOrder,
                            onPressed: () => context.pushRoute(
                                TrackMapScreen(salesOrder: salesOrder))))
                  ],
                ),
          status: status),
      'Delivered' => _step(
          title: Text(S.of(context).orderIsDelivered),
          subtitle: Text(
              '${S.of(context).on} ${salesOrder.deliveryDate.dateFormatted}  ${salesOrder.time}'),
          content: const SizedBox.shrink(),
          status: status,
        ),
      _ => throw const FormatException('Invalid')
    };
  }

  Step _step(
      {required Widget title,
      Widget? subtitle,
      required Widget content,
      required String status}) {
    final currentIndex = statuses.indexWhere((element) => element == status);
    return Step(
      title: title,
      subtitle: subtitle,
      content: content,
      state: currentIndex >
              statuses.indexWhere((element) => element == salesOrder.status)
          ? StepState.disabled
          : currentIndex <
                  statuses.indexWhere((element) => element == salesOrder.status)
              ? StepState.complete
              : StepState.indexed,
    );
  }

  String _getTranslatedStatus(String status, BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    return switch (status) {
      'Submitted' => isArabic ? 'تم تقديم الطلب.' : status,
      'Loaded' => isArabic ? 'تم تحميل الطلب.' : status,
      'On the way' => isArabic ? 'الطلب قيد التوصيل' : status,
      'Delivered' => isArabic ? 'تم التوصيل' : status,
      _ => throw const FormatException('Invalid')
    };
  }
}

class _StepperIcon extends StatelessWidget {
  const _StepperIcon({this.backgroundColor = AppColors.darkBlue});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 15,
      ),
    );
  }
}
