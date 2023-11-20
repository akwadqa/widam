import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';

class ExpressWidget extends StatelessWidget {
  const ExpressWidget({super.key, this.isBig = false});
  final bool isBig;
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Stack(
      children: [
        Assets.images.expressBackground
            .svg(height: isBig ? 25 : 18, width: isBig ? 80 : 70),
        Positioned(
          top: isBig ? 5 : 3,
          left: isBig ? 8 : 5,
          child: Assets.icons.rocketIcon
              .svg(width: isBig ? 15 : 12, height: isBig ? 15 : 12),
        ),
        Positioned(
            top: isBig ? 3 : 2,
            right: isBig
                ? isRtl
                    ? 16
                    : 25
                : 12,
            child: Text(
              S.of(context).express,
              style: TextStyle(
                color: Colors.white,
                fontSize: isBig
                    ? 12
                    : isRtl
                        ? 8
                        : 10,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
