import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_close_button.dart';
import 'package:widam/src/common_widgets/banner/app_banner_dialog.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/common_widgets/submit_button.dart';
import 'package:widam/src/features/order_review/domain/order_review/order_review.dart';
import 'package:widam/src/features/order_review/presentation/review_form_field/review_form_field.dart';
import 'package:widam/src/features/order_review/presentation/send_review_controller.dart';

class OrderReviewBottomSheet extends StatefulWidget {
  const OrderReviewBottomSheet({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderReviewBottomSheet> createState() => _OrderReviewBottomSheetState();
}

class _OrderReviewBottomSheetState extends State<OrderReviewBottomSheet> {
  double? _deliverySpeed;
  double? _productQuality;
  double? _customerService;
  String? _comment;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                              child: Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: AppCloseButton())),
                          Expanded(
                              child: Assets.images.reviewImagePerson.svg()),
                          const Spacer()
                        ],
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Text(S.of(context).reviewQuestion,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 15),
                      _Title(title: S.of(context).orderReview),
                      const SizedBox(height: 14),
                      ReviewFormField(
                          validator: (value) =>
                              value == null ? S.of(context).required : null,
                          title: S.of(context).deliverySpeed,
                          onSaved: (value) => _deliverySpeed = value),
                      const SizedBox(height: 20),
                      ReviewFormField(
                          validator: (value) =>
                              value == null ? S.of(context).required : null,
                          title: S.of(context).productQuality,
                          onSaved: (value) => _productQuality = value),
                      const SizedBox(height: 20),
                      ReviewFormField(
                          validator: (value) =>
                              value == null ? S.of(context).required : null,
                          title: S.of(context).customerService,
                          onSaved: (value) => _customerService = value),
                      const SizedBox(height: 30),
                      _Title(title: S.of(context).commentsAndFeedback),
                      const SizedBox(height: 14),
                      TextFormField(
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            hintText: S.of(context).writeYourCommentHere,
                            label: Text(
                              S.of(context).yourComment,
                            )),
                        onSaved: (value) => _comment = value,
                      ),
                      const SizedBox(height: 100),
                    ]),
              ),
            ),
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return Positioned(
                  bottom: isKeyboardVisible ? 5 : 30,
                  left: 0,
                  right: 0,
                  child: Consumer(
                    builder: (context, ref, child) {
                      ref.listen(sendReviewControllerProvider,
                          (previous, next) {
                        if (next is AsyncError) {
                          showAppBannerDialog(
                              context, next.error.toString(), next.stackTrace);
                        }
                        if (next is AsyncData && next.value != null) {
                          context.popRoute();
                        }
                      });
                      final sendReviewAsync =
                          ref.watch(sendReviewControllerProvider);
                      if (sendReviewAsync is AsyncLoading) {
                        return const FadeCircleLoadingIndicator();
                      }
                      return SubmitButton(
                          text: S.of(context).submit,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              ref
                                  .read(sendReviewControllerProvider.notifier)
                                  .sendReview(OrderReview(
                                      orderId: widget.orderId,
                                      commentsFeedback: _comment,
                                      customerService: _customerService,
                                      deliverySpeed: _deliverySpeed,
                                      productQuality: _productQuality));
                            }
                          });
                    },
                  ));
            })
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black));
  }
}
