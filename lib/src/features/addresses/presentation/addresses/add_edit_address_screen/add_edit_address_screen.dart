import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/src/common_widgets/asterisk_icon.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/app_cached_network_image.dart';
import '../../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../domain/address/address.dart';
import '../../../domain/address/country.dart';
import '../../../domain/geofence.dart';
import '../../../domain/location/location.dart';
import '../adaptive_back_button.dart';
import 'add_edit_address_controller.dart';
import 'coordinates_controller.dart';
import '../../../../../utils/utils.dart';
import '../../../../../common_widgets/mobile_number_prefix.dart';
import '../../../../../common_widgets/submit_button.dart';
import '../../../../../constants/strings.dart';
import '../../maps/location_picker/location_picker.dart';
import 'address_labels.dart';

@RoutePage()
class AddEditAddressScreen extends ConsumerStatefulWidget {
  const AddEditAddressScreen({
    super.key,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.geofenceId,
  });

  final Address? address;
  final String latitude;
  final String longitude;
  final String geofenceId;

  @override
  ConsumerState<AddEditAddressScreen> createState() =>
      _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends ConsumerState<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _keys = List.generate(7, (_) => GlobalKey<FormFieldState>());

  String? _addressTitle;
  String? _zoneNumber;
  String? _streetNo;
  String? _buildingNo;
  String? _addressDescription;
  bool? _isDefault;
  String? _fullname;
  String? _mobile;
  String? _addressType;

  @override
  void initState() {
    Future(() {
      ref
          .read(coordinatesControllerProvider.notifier)
          .setCoordinates((lat: widget.latitude, long: widget.longitude));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: Platform.isIOS ? const ClampingScrollPhysics() : null,
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Text(S.of(context).locationInformation, style: textStyle),
                      const SizedBox(height: 10.0),
                      Consumer(
                        builder: (context, ref, child) {
                          final coordinates =
                              ref.watch(coordinatesControllerProvider);
                          if (coordinates == null) {
                            return const SizedBox.shrink();
                          }
                          return InkWell(
                            onTap: () {
                              showAdaptiveModalBottomSheet<Location?>(
                                      context: context,
                                      enableDrag: false,
                                      builder: (context) =>
                                          const LocationPicker())
                                  .then((Location? location) {
                                if (location != null) {
                                  ref
                                      .read(coordinatesControllerProvider
                                          .notifier)
                                      .setCoordinates((
                                    lat: location.latitude!,
                                    long: location.longitude!
                                  ));
                                }
                              });
                            },
                            child: AppCachedNetworkImage(
                                imageUrl: getMapImageURL(
                                    coordinates.lat,
                                    coordinates.long,
                                    Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? 'en'
                                        : 'ar',
                                    width: 700,
                                    height: 160),
                                height: 90,
                                width: double.infinity,
                                fit: BoxFit.fitWidth),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Text(S.of(context).addressTitle, style: textStyle),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: _keys[0],
                        initialValue: widget.address?.addressTitle,
                        decoration: InputDecoration(
                          hintText: S.of(context).addressTitleHint,
                          labelText: S.of(context).addressTitle,
                          suffixIcon: const AsteriskIcon(),
                        ),
                        validator: qValidator([
                          IsRequired(S.of(context).required),
                        ]),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _addressTitle = value,
                      ),
                      const SizedBox(height: 30.0),
                      Text(S.of(context).addressDetails, style: textStyle),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: _keys[1],
                        initialValue: widget.address?.zone,
                        decoration: InputDecoration(
                            hintText: S.of(context).zoneNumberHint,
                            labelText: S.of(context).zoneNumber,
                            suffixIcon: const AsteriskIcon()),
                        validator: qValidator([
                          IsRequired(S.of(context).required),
                          IsNumber(S.of(context).shouldBeNumber),
                        ]),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ArabicNumberInputFormatter(),
                          LengthLimitingTextInputFormatter(2)
                        ],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _zoneNumber = value,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: _keys[2],
                        initialValue: widget.address?.streetNo,
                        decoration: InputDecoration(
                            hintText: S.of(context).streetNoHint,
                            labelText: S.of(context).streetNo,
                            suffixIcon: const AsteriskIcon()),
                        validator: qValidator([
                          IsRequired(S.of(context).required),
                          IsNumber(S.of(context).shouldBeNumber),
                        ]),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ArabicNumberInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _streetNo = value,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: _keys[3],
                        initialValue: widget.address?.buildingNo,
                        decoration: InputDecoration(
                            hintText: S.of(context).buildingNoHint,
                            labelText: S.of(context).buildingNo,
                            suffixIcon: const AsteriskIcon()),
                        validator: qValidator([
                          IsRequired(S.of(context).required),
                          IsNumber(S.of(context).shouldBeNumber),
                        ]),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ArabicNumberInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _buildingNo = value,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: _keys[4],
                        // initialValue: widget.address?.address,
                        decoration: InputDecoration(
                            hintText: S.of(context).addressHint,
                            labelText: S.of(context).describeYourAddress),
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.done,
                        maxLines: 3,
                        onSaved: (value) => _addressDescription = value,
                      ),
                      if (widget.address != null &&
                          ref
                                  .read(appDataControllerProvider)
                                  .asData
                                  ?.value
                                  .address !=
                              null) ...[
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).makeThisDefault,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            _Switch(
                              initialValue:
                                  widget.address?.preferredShippingAddress == 1,
                              onChanged: (value) => _isDefault = value,
                            )
                          ],
                        ),
                      ],
                      const SizedBox(height: 40.0),
                      Text(S.of(context).reciverInformation, style: textStyle),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        key: _keys[5],
                        initialValue: widget.address?.fullName ??
                            ref.read(userDataProvider)?.fullName,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: S.of(context).fullNameHint,
                            labelText: S.of(context).fullName,
                            suffixIcon: const AsteriskIcon()),
                        validator: qValidator([
                          IsRequired(S.of(context).required),
                        ]),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _fullname = value,
                      ),
                      const SizedBox(height: 20.0),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          key: _keys[6],
                          initialValue:
                              widget.address?.phone.replaceAll('974', ''),
                          decoration: InputDecoration(
                              hintText: S.of(context).enterYourMobileNo,
                              labelText: S.of(context).mobileNo,
                              prefixIconConstraints:
                                  const BoxConstraints(maxWidth: 100),
                              prefixIcon: const MobileNumberPrefix(),
                              suffixIcon: const AsteriskIcon()),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ArabicNumberInputFormatter(),
                          ],
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          validator: mobileNumberValidation(context),
                          onSaved: (value) => _mobile =
                              '${Strings.qatarInternationalCodeNumber}$value',
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Text(S.of(context).addressLabel, style: textStyle),
                      const SizedBox(height: 15.0),
                      AddressLabels(
                        initialValue: ref
                            .read(addressLabelsProvider)
                            .firstWhere(
                                (element) =>
                                    element.value ==
                                    widget.address?.addressType,
                                orElse: () =>
                                    ref.read(addressLabelsProvider).first),
                        onSaved: (newValue) => _addressType = newValue?.value,
                      ),
                      const SizedBox(height: 150.0),
                    ]),
              ),
            ),
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return Positioned(
                bottom: isKeyboardVisible ? 5 : 40 + getBottomPadding(context),
                left: 0,
                right: 0,
                child: Consumer(builder: (context, ref, child) {
                  ref.listen(addEditAddressControllerProvider,
                      (previous, next) {
                    if (next is AsyncData && next.value != null) {
                      context.maybePop();
                    } else if (next is AsyncError) {
                      showAppBannerDialog(
                          context, next.error.toString(), next.stackTrace);
                    }
                  });
                  final addressAsync =
                      ref.watch(addEditAddressControllerProvider);
                  if (addressAsync is AsyncLoading) {
                    return const FadeCircleLoadingIndicator();
                  }
                  return widget.address == null
                      ? _addAddressButton()
                      : _updateAddressButton();
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

  SubmitButton _addAddressButton() {
    return SubmitButton(
      text: S.of(context).addAddress,
      onPressed: _submit,
    );
  }

  SubmitButton _updateAddressButton() {
    return SubmitButton(
      text: S.of(context).updateAddress,
      onPressed: () => _submit(true),
    );
  }

  void _submit([bool update = false]) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Address address = Address(
          addressType: _addressType!,
          buildingNo: _buildingNo!,
          customerFullname: '',
          latitude: ref.read(coordinatesControllerProvider)!.lat,
          longitude: ref.read(coordinatesControllerProvider)!.long,
          phone: _mobile!,
          preferredShippingAddress: _isDefault != null
              ? _isDefault!
                  ? 1
                  : 0
              : null,
          streetNo: _streetNo!,
          landmark: _addressDescription,
          zone: _zoneNumber!,
          country: Country(countryName: 'Qatar', countryId: 'Qatar'),
          addressId: update ? widget.address!.addressId : '',
          addressTitle: _addressTitle!,
          customerId: '',
          geofence: Geofence(geofenceId: widget.geofenceId, geofenceName: ''),
          fullName: _fullname!);
      if (update) {
        ref
            .read(addEditAddressControllerProvider.notifier)
            .updateAddress(address);
      } else {
        ref.read(addEditAddressControllerProvider.notifier).addAddress(address);
      }
    } else {
      final key = _keys.firstWhere((element) => !element.currentState!.isValid);
      RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      _scrollController.animateTo(offset.dy,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _Switch extends StatefulWidget {
  const _Switch({
    this.onChanged,
    this.initialValue,
  });

  final void Function(bool)? onChanged;
  final bool? initialValue;

  @override
  State<_Switch> createState() => _SwitchState();
}

class _SwitchState extends State<_Switch> {
  late bool _value;

  @override
  void initState() {
    _value = widget.initialValue ?? false;
    widget.onChanged?.call(_value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = !_value;
          });
          widget.onChanged?.call(value);
        });
  }
}
