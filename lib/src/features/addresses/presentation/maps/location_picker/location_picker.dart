import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widam/src/theme/app_colors.dart';
import 'package:widam/src/utils/utils.dart';
import 'current_location_button.dart';

import '../../../../../../generated/l10n.dart';
import '../../../domain/place/place.dart';
import '../location_auto_complete/location_auto_complete.dart';
import '../location_permission_checker_banner/location_permission_checker_banner.dart';
import '../validate_coordinates_banner/validate_coordinates_banner.dart';
import 'confirm_location_button.dart';
import 'skip_button.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker(
      {super.key,
      this.latitude,
      this.longitude,
      this.withDefaultLocation = false});

  final double? latitude;
  final double? longitude;
  final bool withDefaultLocation;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final Completer<GoogleMapController> _controller = Completer();

  late LatLng _currentPosition;

  @override
  void initState() {
    _currentPosition =
        LatLng(widget.latitude ?? 25.286106, widget.longitude ?? 51.534817);

    _goToCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(S.of(context).chooseYourLocation,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 12.0,
                  ),
                  myLocationButtonEnabled: false,
                  onCameraMove: (position) {
                    setState(() {
                      _currentPosition = position.target;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ValidateCoordinatesBanner(
                          currentPosition: _currentPosition),
                      const LocationPermissionCheckerBanner(),
                      LocationAutoComplete(onSelected: _goToPlace)
                    ],
                  ),
                ),
                Positioned(
                    bottom: 30 + getBottomPadding(context),
                    right: 16,
                    left: 16,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CurrentLocationButton(
                                onPressed: _goToCurrentLocation),
                            SkipButton(
                                withDefaultLocation:
                                    widget.withDefaultLocation),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ConfirmLocationButton(currentPosition: _currentPosition)
                      ],
                    )),
                const Center(
                  child: Icon(Icons.location_on_rounded,
                      color: AppColors.red, size: 40),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToCurrentLocation() async {
    final LatLng? myLocation = await _getMyLocation();
    if (myLocation != null) {
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          myLocation,
          14,
        ),
      );
      _currentPosition = myLocation;
    }
  }

  Future<LatLng?> _getMyLocation() async {
    final location = await _determinePosition();
    return LatLng(location.latitude, location.longitude);
  }

  Future<Position> _determinePosition() async {
    await _requestLocationPermission();
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  void _goToPlace(Place place) async {
    final List<Location> locations =
        await locationFromAddress(place.description);

    final Location location = locations.first;

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(location.latitude, location.longitude),
        14,
      ),
    );
  }
}
