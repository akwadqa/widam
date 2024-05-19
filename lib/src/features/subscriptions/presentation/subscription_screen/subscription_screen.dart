import 'package:auto_route/annotations.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';
import 'subscription_body/subscription_body.dart';

part 'subscription_screen.g.dart';

final stepIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

@riverpod
List<String> titles(TitlesRef ref) => [
      S.current.selectYourProducts,
      S.current.setYourSchedule,
      S.current.confirmation
    ];

@riverpod
List<SvgGenImage> icons(IconsRef ref) =>
    [Assets.icons.newCart, Assets.icons.calenderIcon, Assets.icons.thumbIcon];

@RoutePage()
class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepIndex = ref.watch(stepIndexProvider);
    final titles = ref.watch(titlesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(titles[stepIndex].replaceFirst('\n', ' '))),
      body: Column(
        children: [
          SizedBox(
            height: 140,
            child: EasyStepper(
              lineStyle: LineStyle(
                lineType: LineType.normal,
                lineLength: MediaQuery.of(context).size.width / 4.5,
                unreachedLineColor: AppColors.brightGray,
                lineThickness: 4,
              ),
              activeStep: stepIndex,
              showLoadingAnimation: false,
              showStepBorder: false,
              finishedStepBackgroundColor: Colors.transparent,
              steps: List.generate(
                titles.length,
                (index) => EasyStep(
                  customStep: Container(
                      decoration: BoxDecoration(
                        color: stepIndex >= index
                            ? AppColors.primary
                            : AppColors.brightGray,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: stepIndex >= index
                          ? const Icon(Icons.check, color: Colors.white)
                          : Text('${index + 1}',
                              style: const TextStyle(
                                  color: AppColors.silver,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))),
                  customTitle: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ref.watch(iconsProvider)[index].svg(
                          colorFilter: ColorFilter.mode(
                              stepIndex >= index
                                  ? AppColors.primary
                                  : AppColors.silver,
                              BlendMode.srcIn)),
                      const SizedBox(height: 6),
                      Text(
                          index == titles.length - 1
                              ? S.of(context).reviewAndConfirm
                              : titles[index],
                          style: TextStyle(
                              color: stepIndex >= index
                                  ? AppColors.primary
                                  : AppColors.silver,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              disableScroll: true,
              onStepReached: (index) {
                if (index < stepIndex) {
                  ref.read(stepIndexProvider.notifier).state = index;
                }
              },
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SubscriptionBody(stepIndex: stepIndex),
          ),
        ],
      ),
    );
  }
}
