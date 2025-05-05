import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../../data/udhiya_coupons_repository.dart';

@RoutePage()
class UdhiyaCouponsScreen extends StatelessWidget {
  const UdhiyaCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).coupons)),
        body: Consumer(builder: (context, ref, _) {
          final couponsAsync = ref.watch(udhiyaCouponsProvider);
          return couponsAsync.when(
              data: (coupons) {
                if (coupons.isEmpty) {
                  return Center(
                    child: Text(S.of(context).noCouponsYet),
                  );
                }
                return ListView.separated(
                    itemCount: coupons.length,
                    itemBuilder: (context, index) {
                      final coupon = coupons[index];
                      return Row(
                        children: [
                          AppCachedNetworkImage(
                              imageUrl: coupon.qrCode,
                              width: 80.0,
                              height: 80.0),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${S.of(context).couponNo} ${coupon.couponId}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Assets.icons.clockIcon.svg(height: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                      coupon.pickupDetails.pickupTimeSlot
                                          .timeFormatted,
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(flex: 3),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(coupon.status,
                                  style: TextStyle(
                                      color: coupon.status == 'Active'
                                          ? Colors.green
                                          : null,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(coupon.pickupDetails.pickupDate.date),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  onPressed: () => context.pushRoute(
                                      UdhiyaCouponDetailsScreen(
                                          couponId: coupon.couponId)),
                                  child: Text(S.of(context).view))
                            ],
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0));
              },
              loading: () => const FadeCircleLoadingIndicator(),
              error: (error, st) =>
                  AppBanner(message: error.toString(), stackTrace: st));
        }));
  }
}
