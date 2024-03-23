import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/cart/application/cart_service.dart';
import 'package:widam/src/features/sales_orders/presentaion/reorder_button/reorder_controller.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class ReorderButton extends ConsumerWidget {
  const ReorderButton({super.key, required this.salesOrderId});
  final String salesOrderId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(reorderControllerProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(updateCartProvider.notifier).setCart(next.value!);
        context.maybePop(true);
      } else if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      }
    });
    final reorderAsyncValue = ref.watch(reorderControllerProvider);
    if (reorderAsyncValue is AsyncLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FadeCircleLoadingIndicator(),
      );
    }
    return ElevatedButton(
      onPressed: () => ref
          .read(reorderControllerProvider.notifier)
          .reorder(salesOrderId: salesOrderId),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      child: Text(S.of(context).reorder),
    );
  }
}
