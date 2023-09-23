import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/loyalty_program_controller.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/points_progress_card.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/redeem_points_button.dart';

import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import 'about_container.dart';
import 'loyalty_points_card.dart';

@RoutePage()
class WidamLoyaltyProgramScreen extends ConsumerWidget {
  const WidamLoyaltyProgramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loyaltyProgramAsync = ref.watch(loyaltyProgramControllerProvider);
    return loyaltyProgramAsync.when(
        skipLoadingOnRefresh: false,
        data: (state) {
          final loyaltyProgram = (state as LoyaltyProgramLoaded).loyaltyProgram;
          return Scaffold(
            appBar: AppBar(
              title: Text(loyaltyProgram.loyaltyProgramName),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  LoyaltyPointsCard(loyaltyProgram: loyaltyProgram),
                  const SizedBox(height: 20),
                  PointsProgressCard(loyaltyProgram: loyaltyProgram),
                  const SizedBox(height: 20),
                  const RedeemPointsButton(),
                  const SizedBox(height: 20),
                  const AboutContainer(),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Material(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: AppBanner(
                      message: error.toString(), stackTrace: stackTrace)),
            )),
        loading: () =>
            const Material(child: Center(child: FadeCircleLoadingIndicator())));
  }
}
