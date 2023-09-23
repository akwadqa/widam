import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/src/features/coupons/data/coupons_repository.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common_widgets/banner/app_banner.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../theme/app_theme.dart';
import 'coupon_code_item.dart';
import '../../../../theme/app_colors.dart';

class CouponCodeSelector extends ConsumerStatefulWidget {
  const CouponCodeSelector({super.key});

  @override
  ConsumerState<CouponCodeSelector> createState() => _CouponCodeSelectorState();
}

class _CouponCodeSelectorState extends ConsumerState<CouponCodeSelector> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final couponCodeSelectorController = ref.watch(couponsProvider);
    return Material(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: couponCodeSelectorController.when(
              data: (coupons) {
                return KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:
                        isKeyboardVisible ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: S.of(context).enterCouponCode,
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.5),
                              ),
                              suffixIcon: Consumer(
                                builder: (context, ref, child) {
                                  final fontFamily =
                                      ref.watch(fontFamilyProvider);
                                  return TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: AppColors.londonRain,
                                        textStyle: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: fontFamily)),
                                    child: Text(S.of(context).apply),
                                  );
                                },
                              )),
                          keyboardType: TextInputType.text,
                          validator: qValidator([
                            IsRequired(S.of(context).required),
                          ]),
                          onSaved: (value) => context.popRoute(value),
                        ),
                      ),
                      if (coupons.isEmpty) const SizedBox(height: 60.0),
                      if (coupons.isNotEmpty) ...[
                        const SizedBox(height: 20.0),
                        Text(S.of(context).applyExistingOffer,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 8.0),
                        ListView.separated(
                            itemBuilder: (context, index) {
                              return CouponCodeItem(coupon: coupons[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 16.0,
                                ),
                            shrinkWrap: true,
                            itemCount: coupons.length)
                      ]
                    ],
                  );
                });
              },
              error: (error, stackTrace) =>
                  AppBanner(message: error.toString(), stackTrace: stackTrace),
              loading: () => const FadeCircleLoadingIndicator())),
    );
  }
}
