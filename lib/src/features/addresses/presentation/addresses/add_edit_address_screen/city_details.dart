import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/src/common_widgets/app%20_drop_down_bottom_sheet.dart';
import 'package:widam/src/common_widgets/asterisk_icon.dart';
import 'package:widam/src/utils/utils.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../data/addresses_repository.dart';
import '../../../domain/address/area.dart';
import '../../../domain/address/city.dart';
import '../../../domain/address/zone.dart';

final selectedCityProvider = StateProvider<City?>((_) => null);
final selectedZoneProvider = StateProvider<Zone?>((_) => null);
final selectedAreaProvider = StateProvider<Area?>((_) => null);

class CityDetails extends ConsumerStatefulWidget {
  const CityDetails({super.key, required this.geofenceId, required this.keys});

  final List<GlobalKey<FormFieldState>> keys;

  final String geofenceId;

  @override
  ConsumerState<CityDetails> createState() => _CityDetailsState();
}

class _CityDetailsState extends ConsumerState<CityDetails> {
  final _cityTextController = TextEditingController();
  final _areaTextController = TextEditingController();
  final _zoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final citiesAsync = ref.watch(citiesProvider(widget.geofenceId));
        return citiesAsync.when(
            data: (cities) {
              final selectedCity = ref.watch(selectedCityProvider) != null
                  ? cities
                      .where((element) =>
                          element.cityId ==
                          ref.watch(selectedCityProvider)!.cityId)
                      .toList()
                      .firstOrNull
                  : null;
              final selectedArea = ref.watch(selectedAreaProvider) != null
                  ? selectedCity?.areas
                      ?.where((element) =>
                          element.areaId ==
                          ref.watch(selectedAreaProvider)?.areaId)
                      .toList()
                      .firstOrNull
                  : null;
              final selectedZone = ref.watch(selectedZoneProvider) != null
                  ? selectedArea?.zones
                      ?.where((element) =>
                          element.zoneId ==
                          ref.watch(selectedZoneProvider)?.zoneId)
                      .toList()
                      .firstOrNull
                  : null;

              _cityTextController.text = selectedCity?.cityName ?? '';
              _areaTextController.text = selectedArea?.areaName ?? '';
              _zoneTextController.text = selectedZone?.zoneNumber ?? '';

              return Column(
                children: [
                  TextFormField(
                    key: widget.keys[1],
                    controller: _cityTextController,
                    readOnly: true,
                    onTap: () {
                      showAdaptiveModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AppDropDownBottomSheet<City>(
                                title: (item) => item.cityName,
                                items: cities,
                                onTap: (item) {
                                  ref
                                      .read(selectedCityProvider.notifier)
                                      .state = item;
                                  _cityTextController.text = item.cityName;
                                });
                          });
                    },
                    decoration: InputDecoration(
                        hintText: S.of(context).cityNameHint,
                        label: Text(S.of(context).cityName),
                        suffixIcon: _suffixIcon),
                    validator: qValidator([
                      IsRequired(S.of(context).required),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      key: widget.keys[2],
                      controller: _areaTextController,
                      readOnly: true,
                      onTap: () {
                        final areas = selectedCity?.areas ?? [];
                        showAdaptiveModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AppDropDownBottomSheet<Area>(
                                  title: (item) => item.areaName,
                                  items: areas,
                                  onTap: (item) {
                                    ref
                                        .read(selectedAreaProvider.notifier)
                                        .state = item;
                                    _areaTextController.text = item.areaName;
                                  });
                            });
                      },
                      decoration: InputDecoration(
                          label: Text(S.of(context).areaName),
                          hintText: S.of(context).areaNameHint,
                          suffixIcon: _suffixIcon),
                      validator: qValidator([
                        IsRequired(S.of(context).required),
                      ])),
                  const SizedBox(height: 20),
                  TextFormField(
                      key: widget.keys[3],
                      controller: _zoneTextController,
                      readOnly: true,
                      onTap: () {
                        showAdaptiveModalBottomSheet(
                            context: context,
                            builder: (context) {
                              final zones = selectedArea?.zones ?? [];
                              return AppDropDownBottomSheet<Zone>(
                                  title: (item) => item.zoneNumber,
                                  items: zones,
                                  onTap: (item) {
                                    ref
                                        .read(selectedZoneProvider.notifier)
                                        .state = item;
                                    _zoneTextController.text = item.zoneNumber;
                                  });
                            });
                      },
                      decoration: InputDecoration(
                          label: Text(S.of(context).zoneNumber),
                          hintText: S.of(context).zoneNumberHint,
                          suffixIcon: _suffixIcon),
                      validator: qValidator([
                        IsRequired(S.of(context).required),
                      ])),
                ],
              );
            },
            error: (error, stackTrace) =>
                AppBanner(message: error.toString(), stackTrace: stackTrace),
            loading: () => const FadeCircleLoadingIndicator());
      },
    );
  }

  Row get _suffixIcon => const Row(
        mainAxisSize: MainAxisSize.min,
        children: [AsteriskIcon(), Icon(Icons.arrow_drop_down)],
      );

  @override
  void dispose() {
    _cityTextController.dispose();
    _areaTextController.dispose();
    _zoneTextController.dispose();
    super.dispose();
  }
}
