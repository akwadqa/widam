import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../cart/application/cart_service.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    const icons = Assets.icons;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: 20 + getBottomPadding(context), top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _NavItem(
            icon: icons.homeIcon.svg(),
            selectedIcon: icons.selectedHomeIcon.svg(),
            label: S.of(context).home,
            isSelected: currentIndex == 0,
            onPressed: () {
              onTap!(0);
            },
          ),
          _NavItem(
            icon: icons.categoriesIcon.svg(),
            selectedIcon: icons.selectedCategoriesIcon.svg(),
            label: S.of(context).category,
            isSelected: currentIndex == 1,
            onPressed: () {
              onTap!(1);
            },
          ),
          _NavItem(
            icon: icons.dealsIcon.svg(),
            selectedIcon: icons.selectedDealsIcon.svg(),
            label: S.of(context).deals,
            isSelected: currentIndex == 2,
            onPressed: () {
              onTap!(2);
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final int cartCount = ref.watch(cartCountProvider);
              final bool isBudgeVisible = cartCount > 0;
              return _NavItem(
                icon: isBudgeVisible
                    ? _CartBudge(
                        cartCount: cartCount.toString(),
                        child: icons.cartIcon.svg())
                    : icons.cartIcon.svg(),
                selectedIcon: isBudgeVisible
                    ? _CartBudge(
                        cartCount: cartCount.toString(),
                        child: icons.selectedCartIcon.svg())
                    : icons.selectedCartIcon.svg(),
                label: S.of(context).cart,
                isSelected: currentIndex == 3,
                onPressed: () {
                  onTap!(3);
                },
              );
            },
          ),
          _NavItem(
            icon: icons.profileIcon.svg(),
            selectedIcon: icons.selectedProfileIcon.svg(),
            label: S.of(context).account,
            isSelected: currentIndex == 4,
            onPressed: () {
              onTap!(4);
            },
          ),
        ],
      ),
    );
  }
}

class _CartBudge extends StatelessWidget {
  const _CartBudge({required this.child, required this.cartCount});
  final Widget child;
  final String cartCount;
  @override
  Widget build(BuildContext context) {
    return Badge(
      textColor: Colors.white,
      backgroundColor: AppColors.red,
      label: Text(cartCount.toString()),
      child: child,
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem(
      {required this.icon,
      required this.label,
      required this.selectedIcon,
      required this.isSelected,
      required this.onPressed});
  final Widget icon;
  final Widget selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          isSelected ? selectedIcon : icon,
          const SizedBox(height: 5),
          Text(label,
              style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.gray,
                  fontSize: 10)),
        ],
      ),
      iconSize: 51,
    );
  }
}
