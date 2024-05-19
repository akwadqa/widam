import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_widget.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../common_widgets/search_field.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../addresses/presentation/maps/address_selector_button/address_selector_button.dart';
import '../../../time_slots/presentation/app_time_slot.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding =
        ref.watch(topPaddingProvider(MediaQuery.paddingOf(context).top));
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
          start: 16, end: 16, bottom: 8, top: topPadding),
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
  const _SearchWidget();

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
            onTap: () => pushItemGroupScreen(
                context: context,
                autoFocus: true,
                itemGroupId: Strings.allItemGroup),
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
