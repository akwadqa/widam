import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/app_data/presentation/splash_screen/splash_screen.dart';
import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_widget.dart';
import 'package:widam/src/features/layouts/data/layouts_repository.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: AddressSelector(foregroundColor: Colors.white)),
              // Spacer(),
               FittedBox(
                    fit: BoxFit.scaleDown,child: AppTimeSlot(foregroundColor: Colors.white)),
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
        final currentLanguage = ref.watch(currentLanguageProvider);
    final currentLanguageNotifier = ref.read(currentLanguageProvider.notifier);
    final String myLanguage = currentLanguage == 'en' ? 'en' : 'عربي';
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
            suffixIcon:  BarcodeWidget(),
            fillColor: Colors.white,
            hintText: S.of(context).searchForAnyProduct,
          ),
        ),
        const SizedBox(width: 10),
       LanguageSwitcher(
        initialLanguage: myLanguage
        
        ,
        onLanguageChanged: (p0) {
             currentLanguageNotifier.changeLanguage(
                        // context,isArabicLanguage
                      );
                      
          ref.invalidate(layoutProvider(LayoutType.home));
          ref.invalidate(layoutProvider(LayoutType.featured));
       },)
          // GestureDetector(
          //           onTap: () {
          //             currentLanguageNotifier.changeLanguage(
          //               // context,isArabicLanguage
          //             );
                      
          // ref.invalidate(layoutProvider(LayoutType.home));
          // ref.invalidate(layoutProvider(LayoutType.featured));
          //   },
          //           child:Text(myLanguage.toUpperCase(),
                    
          //              style: Theme.of(context).textTheme.displaySmall!.copyWith(
          //         fontSize: 15,
          //         color:  AppColors.aliceBlue,
                  
          //         fontWeight: FontWeight.bold,
          //       ),
          //           )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(20);
}

class LanguageSwitcher extends StatefulWidget {
  final Function(String) onLanguageChanged;
  final String initialLanguage;

  const LanguageSwitcher({
    Key? key,
    required this.onLanguageChanged,
    this.initialLanguage = 'en',
  }) : super(key: key);

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late String currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = widget.initialLanguage;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: currentLanguage == 'en' ? 0.0 : 1.0,
      end: currentLanguage == 'en' ? 0.0 : 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLanguage() {
    setState(() {
      currentLanguage = currentLanguage == 'en' ? 'ar' : 'en';
    });

    _slideAnimation = Tween<double>(
      begin: _slideAnimation.value,
      end: currentLanguage == 'en' ? 0.0 : 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward(from: 0.0);
    widget.onLanguageChanged(currentLanguage);
  }

  Widget _buildSaudiFlag() {
    return ClipOval(
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color:const Color(0xFF006C35), 
          shape: BoxShape.circle,
        ),
        child:
        
        
         Text(
          "🇸🇦",
          style: TextStyle(fontSize: 20),
          
        )
      ),
    );
  }

  Widget _buildBritishFlag() {
    return ClipOval(
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFF012169),
          shape: BoxShape.circle,
        ),
        child:
        
        
         Text(
          "🇬🇧",
          style: TextStyle(fontSize: 20),
          
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: SizedBox(
        width: 80,
        height: 40,
        child: Card.outlined(
          color: Colors.grey[300],
          elevation: 4,
          shape: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.white ),
            borderRadius: BorderRadius.circular(20),
          ),
          // decoration: BoxDecoration(
          //   color: Colors.grey[300],
          //   borderRadius: BorderRadius.circular(20),
          // ),
          child: Row(
            children: [
              // Circular flag icon
              Container(
                width: 36,
                height: 36,
                // margin: const EdgeInsets.all(2),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   shape: BoxShape.circle,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black.withOpacity(0.15),
                //       blurRadius: 4,
                //       offset: const Offset(0, 2),
                //     ),
                //   ],
                // ),
                child: Center(
                  child: currentLanguage == 'en'
                      ? _buildSaudiFlag()
                      : _buildBritishFlag(),
                ),
              ),
              // Language text
              Expanded(
                child: Center(
                  child: Text(
                    currentLanguage == 'en' ?   'عربي':'EN',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
