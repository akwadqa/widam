import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';

class BestSellerBadge extends StatelessWidget {
  const BestSellerBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.bestSellerBackground.svg(),
        Positioned.fill(
          child: Center(
            child: Text(
              S.of(context).bestSeller,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
