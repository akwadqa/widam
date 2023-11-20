import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/main/presentation/item_details_sheet_controller.dart';

import '../home_app_bar/home_app_bar.dart';
import '../home_body/home_body.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ProviderScope(overrides: [
        itemDetailsSheetControllerProvider
            .overrideWith(() => ItemDetailsSheetController())
      ], child: const HomeBody()),
    );
  }
}
