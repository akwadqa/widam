import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../gen/assets.gen.dart';
import 'widgets/home_app_bar_delivery_card.dart';
import 'widgets/home_app_bar_search_row.dart';

/// Home header: delivery slot + address card, then logo, search and language
/// switch. Its gradient is `HomeAppBarBackground`, painted by `HomeScreen`
/// behind the header and the top of the page.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  static const double _horizontalPadding = 16;
  static const double _topPadding = 16;
  static const double _bottomPadding = 6;
  static const double _rowSpacing = 12;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          _horizontalPadding,
          MediaQuery.paddingOf(context).top + _topPadding,
          _horizontalPadding,
          _bottomPadding,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HomeAppBarDeliveryCard(),
            SizedBox(height: _rowSpacing),
            HomeAppBarSearchRow(),
          ],
        ),
      ),
    );
  }
}

/// Old pill-shaped language switch, replaced by `HomeAppBarLanguageButton`.
/// Kept until its deletion is approved.
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

  Widget _buildQatarFlag() {
    return ClipOval(
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 112, 55, 72),
          shape: BoxShape.circle,
        ),
        child: Assets.icons.download.image(),

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
          child: Text(
            "🇬🇧",
            style: TextStyle(fontSize: 20),
          )),
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
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                child: Center(
                  child: currentLanguage == 'en'
                      ? _buildQatarFlag()
                      : _buildBritishFlag(),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    currentLanguage == 'en' ? 'عربي' : 'EN',
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

