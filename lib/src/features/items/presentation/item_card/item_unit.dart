import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class ItemUnit extends StatelessWidget {
  const ItemUnit({Key? key, required this.stockUom}) : super(key: key);
  final String stockUom;
  @override
  Widget build(BuildContext context) {
    return Text(stockUom,
        style: const TextStyle(fontSize: 12, color: AppColors.taupeGray));
  }
}
