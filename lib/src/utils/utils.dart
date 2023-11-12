import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/src/constants/images.dart';
import 'package:widam/src/features/main/presentation/item_details_sheet_controller.dart';

import '../../generated/l10n.dart';
import '../common_widgets/banner/app_banner_dialog.dart';
import '../common_widgets/fade_circle_loading_indicator.dart';
import '../constants/keys.dart';
import '../features/addresses/presentation/maps/validate_coordinates_banner/validate_coordinates_notifier.dart';
import '../features/items/domain/item_details/item_details.dart';
import '../features/items/presentation/item_details/item_details_body/item_details_content.dart';
import '../routing/app_router.gr.dart';

class ArabicNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAll(RegExp(r'^[٠-٩]+$'), '');

    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}

class UserNameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String trimmedText = newValue.text.trimLeft().replaceAll(RegExp(r'^[. -]+'), '');
    trimmedText = trimmedText.trimRight().replaceAll(RegExp(r'[. -]+$'), '');

    return TextEditingValue(
      text: trimmedText,
      selection: newValue.selection,
    );
  }
}

bool isInvalidLocation(ValidateCoordinatesState state, LatLng position) {
  final bool isLoaded = state is ValidateCoordinatesLoaded;
  final bool isInvalid = isLoaded && (state.location.isValid == false);
  final double currentLatitude = position.latitude;
  final double currentLongitude = position.longitude;
  final bool isFirstMarker = isLoaded &&
      double.tryParse(state.location.latitude ?? '') == currentLatitude &&
      double.tryParse(state.location.longitude ?? '') == currentLongitude;
  final bool isDisabled = isInvalid && isFirstMarker;
  return isDisabled;
}

extension DateFormatExtension on DateTime {
  String toFormattedString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}

Future<T?> showAdaptiveModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = Colors.black45,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  Curve? previousRouteAnimationCurve,
  bool useRootNavigator = false,
  bool bounce = true,
  bool? isDismissible,
  bool enableDrag = true,
  Duration? duration,
  RouteSettings? settings,
  Color? transitionBackgroundColor,
  BoxShadow? shadow,
  SystemUiOverlayStyle? overlayStyle,
  double? closeProgressThreshold,
}) {
  if (Platform.isIOS) {
    return showCupertinoModalBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      expand: expand,
      secondAnimation: secondAnimation,
      animationCurve: animationCurve,
      previousRouteAnimationCurve: previousRouteAnimationCurve,
      useRootNavigator: useRootNavigator,
      bounce: bounce,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
      settings: settings,
      transitionBackgroundColor: transitionBackgroundColor,
      shadow: shadow,
      overlayStyle: overlayStyle,
      closeProgressThreshold: closeProgressThreshold,
    );
  }

  return showMaterialModalBottomSheet(
    context: context,
    builder: builder,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    expand: expand,
    secondAnimation: secondAnimation,
    animationCurve: animationCurve,
    useRootNavigator: useRootNavigator,
    bounce: bounce,
    isDismissible: isDismissible ?? true,
    enableDrag: enableDrag,
    duration: duration,
    settings: settings,
    closeProgressThreshold: closeProgressThreshold,
  );
}

void navigateToItemDetails(
    {required BuildContext context,
    required WidgetRef ref,
    required String itemId,
    String? itemType,
    int? isMubadara,
    String? mubadaraId,
    int? hasProductOptions,
    String? attributionToken}) {
  if (itemType == 'V' || isMubadara == 1 || hasProductOptions == 1) {
    context
        .pushRoute(ItemDetailsScreen(itemId: itemId, mubadaraId: mubadaraId));
  } else {
    ref
        .read(itemDetailsSheetControllerProvider.notifier)
        .getDetails(itemId: itemId, attributionToken: attributionToken);
  }
}

void listenItemDetailsSheet(WidgetRef ref, BuildContext context) {
  ref.listen(itemDetailsSheetControllerProvider, (previous, next) {
    if (next is AsyncError) {
      showAppBannerDialog(context, next.error.toString(), next.stackTrace);
    } else if (next is AsyncData && next.asData!.value != null) {
      final ItemDetails item = next.asData!.value!.itemDetails;
      if (previous is AsyncLoading) {
        context.popRoute().then((value) {
          _showItemDetailsSheet(
              item: item,
              context: context,
              attributionToken: next.asData!.value!.attributionToken);
        });
      } else {
        _showItemDetailsSheet(
            item: item,
            context: context,
            attributionToken: next.asData!.value!.attributionToken);
      }
    } else if (next is AsyncLoading) {
      showDialog(
          context: context,
          builder: (_) => const FadeCircleLoadingIndicator(color: Colors.grey));
    }
  });
}

void _showItemDetailsSheet(
    {required ItemDetails item,
    required BuildContext context,
    String? attributionToken}) {
  showAdaptiveModalBottomSheet(
      animationCurve: Curves.easeOutQuart,
      barrierColor: Colors.black38,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Material(
              child: ItemDetailsContent(
                  itemDetails: item,
                  isLoading: false,
                  attributionToken: attributionToken)),
        );
      },
      context: context);
}

String getMapImageURL(String latitude, String longitude, String language,
    {int zoom = 18, int width = 600, int height = 400}) {
  final url =
      'https://maps.googleapis.com/maps/api/staticmap?size=${width}x$height&markers=anchor:30,40|icon:${Images.customerMarker}|$latitude,$longitude&visible=$latitude,$longitude&zoom=$zoom&key=${Keys.googleAPIKey}&language=$language';
  return url;
}

String? Function(String?) mobileNumberValidation(BuildContext context) {
  return qValidator([
    IsRequired(S.of(context).required),
    MaxLength(8, S.of(context).mustBeEightDigits),
    MinLength(8, S.of(context).mustBeEightDigits),
    RegExpRule(
        RegExp(r'^([3567])\d+'), S.of(context).qatariPhoneNumberValidator)
  ]);
}

double getBottomPadding(BuildContext context) {
  return MediaQuery.paddingOf(context).bottom > 20 && Platform.isAndroid
      ? MediaQuery.paddingOf(context).bottom
      : 0;
}

Future<void> pushItemGroupScreen(
    {required BuildContext context,
    bool autoFocus = false,
    required String itemGroupId}) async {
  final int? index = await context.pushRoute(
      ItemGroupScreen(autoFocus: autoFocus, itemGroupId: itemGroupId)) as int?;
  if (index != null) {
    context.tabsRouter.setActiveIndex(index);
  }
}
