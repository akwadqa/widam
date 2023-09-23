import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';

class StockBanner extends StatelessWidget {
  const StockBanner(
      {super.key, this.fontSize = 14, this.oppositeDirection = false});
  final double fontSize;
  final bool oppositeDirection;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(context, oppositeDirection),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
        color: AppColors.darkOrange,
        child: Center(
          child: Text(S.of(context).availableSoon,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  final BuildContext context;
  final bool? oppositeDirection;
  _CustomClipper(this.context, [this.oppositeDirection]);
  @override
  Path getClip(Size size) {
    if (Directionality.of(context) ==
        (oppositeDirection == true ? TextDirection.ltr : TextDirection.rtl)) {
      return Path()
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width - 3.6, size.height)
        ..lineTo(0, size.height)
        ..lineTo(3.6, size.height / 2)
        ..close();
    }
    return Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(3.6, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - 3.6, size.height / 2)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
