import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/mubadara_details/mubadara_details.dart';
import '../option_label.dart';
import '../../../../../theme/app_colors.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../utils/utils.dart';
import 'package:image_picker/image_picker.dart';
part 'mubadara_fields.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<FormState> mubadaraFormKey(MubadaraFormKeyRef ref) =>
    GlobalKey<FormState>();

class MubadaraFields extends ConsumerWidget {
  const MubadaraFields({super.key, required this.mubadaraDetails});
  final MubadaraDetails mubadaraDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(mubadaraFormKeyProvider),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptionLabel(label: mubadaraDetails.qidFieldLabel),
          const SizedBox(height: 8.0),
          QIDTextFormField(mubadaraDetails: mubadaraDetails),
          const SizedBox(height: 30.0),
          OptionLabel(label: mubadaraDetails.qidCopyLabel),
          const SizedBox(height: 8.0),
          _QIDAttachmentFormField(
              context: context, mubadaraDetails: mubadaraDetails, ref: ref),
        ],
      ),
    );
  }
}

final qidNumberProvider = StateProvider.autoDispose<String>((ref) => '');

class QIDTextFormField extends ConsumerStatefulWidget {
  const QIDTextFormField({super.key, required this.mubadaraDetails});

  final MubadaraDetails mubadaraDetails;

  @override
  ConsumerState<QIDTextFormField> createState() => _QIDTextFormFieldState();
}

class _QIDTextFormFieldState extends ConsumerState<QIDTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.mubadaraDetails.qidFieldPlaceholder,
            border: _border,
            enabledBorder: _border),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            ArabicNumberInputFormatter(),
          ],
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).required;
            }
            if (value.length != 11) {
              return S.of(context).mustBeElevenDigits;
            }
            return null;
          },
          onSaved: (value) =>
              ref.read(qidNumberProvider.notifier).state = value!,
        ),
      ],
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: AppColors.taupeGray, width: 0.5),
      );
}

final qidAttachmentProvider = StateProvider.autoDispose<XFile?>((ref) => null);

class _QIDAttachmentFormField extends FormField<XFile?> {
  _QIDAttachmentFormField(
      {required BuildContext context,
      required MubadaraDetails mubadaraDetails,
      required WidgetRef ref})
      : super(
            validator: (value) {
              if (value == null) {
                return S.of(context).required;
              }
              return null;
            },
            onSaved: (value) =>
                ref.read(qidAttachmentProvider.notifier).state = value!,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      final imageSource = await showAdaptiveDialog<ImageSource>(
                          context: state.context,
                          builder: (context) => AlertDialog.adaptive(
                                  title: Text(S.of(context).pickImage),
                                  content: Text(
                                      S.of(context).pleaseSelectImageSource),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          context.popRoute(ImageSource.camera),
                                      child: Text(S.of(context).camera),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          context.popRoute(ImageSource.gallery),
                                      child: Text(S.of(context).gallery),
                                    ),
                                  ]));
                      if (imageSource != null) {
                        final image =
                            await ImagePicker().pickImage(source: imageSource);
                        if (image != null) {
                          state.didChange(image);
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(4.0),
                    child: state.value == null
                        ? DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: const [7, 2],
                            radius: const Radius.circular(4),
                            color: AppColors.cyan,
                            child: _containerChild(
                                context, mubadaraDetails, state),
                          )
                        : Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(color: Colors.green),
                                ),
                                margin: const EdgeInsetsDirectional.only(
                                    top: 5, end: 5),
                                child: _containerChild(
                                    context, mubadaraDetails, state),
                              ),
                              const PositionedDirectional(
                                top: 0.0,
                                end: 0.0,
                                child: Icon(Icons.check_circle,
                                    color: Colors.green, size: 16.0),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: state.hasError ? 8.0 : 0.0),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12.0),
                      child: Text(state.errorText!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12.0)),
                    )
                ],
              );
            });

  static Widget _containerChild(BuildContext context,
          MubadaraDetails mubadaraDetails, FormFieldState<XFile?> state) =>
      Container(
        width: MediaQuery.of(context).size.width / 2,
        color: AppColors.whiteSmoke,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                state.value == null
                    ? mubadaraDetails.qidCopyPlaceholder
                    : S.of(context).qidAttached,
                style: TextStyle(
                    color: state.value == null
                        ? AppColors.primary
                        : AppColors.taupeGray,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500)),
            Assets.icons.idCardIcon.svg()
          ],
        ),
      );
}
