import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/routing/app_router.gr.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../../../theme/app_theme.dart';

class PendingOrderCard extends StatelessWidget {
  const PendingOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.aliceBlue,
        child: Consumer(
          builder: (context, ref, child) {
            final fontFamily = ref.watch(fontFamilyProvider);
            return ListTile(
              title: Text(S.of(context).pendingOrderTitle),
              titleTextStyle: TextStyle(
                  fontFamily: fontFamily,
                  color: AppColors.lapisBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              subtitle: Text(S.of(context).pendingOrderDescription),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  context.pushRoute(SalesOrdersScreen(initialIndex: 1)),
              textColor: AppColors.lapisBlue,
              iconColor: AppColors.lapisBlue,
            );
          },
        ));
  }
}
