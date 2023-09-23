import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_widget.dart';
import '../../../../../main.dart';
import '../../../../common_widgets/search_field.dart';
import '../../../../routing/app_router.gr.dart' as router;
import '../../../../theme/app_colors.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../addresses/presentation/maps/address_selector_button/address_selector_button.dart';
import '../../../time_slots/presentation/app_time_slot.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCentralizedNotch = ref.watch(hasCentralizedNotchProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
        color: AppColors.primary,
      ),
      padding: EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          bottom: 8,
          top: hasCentralizedNotch == true ? 40 : 30),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AddressSelector(foregroundColor: Colors.white),
              Spacer(),
              AppTimeSlot(foregroundColor: Colors.white),
            ],
          ),
          _SearchWidget(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}

class _SearchWidget extends ConsumerWidget implements PreferredSizeWidget {
  const _SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Assets.splash.logo.image(height: 40),
        const SizedBox(width: 10),
        Expanded(
          child: SearchField(
            height: 35,
            readOnly: true,
            onTap: () => context.pushRoute(router.ItemGroupScreen(autoFocus: true, itemGroupId: Strings.allItemGroup)),
            suffixIcon: const BarcodeWidget(),
            fillColor: Colors.white,
            hintText: S.of(context).searchForAnyProduct,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(20);
}
