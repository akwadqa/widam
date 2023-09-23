import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  final List<Marker> _markers = [];

  late LatLng _initialPosition;

  @override
  void initState() {
    _initialPosition =
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
                  markers: Set<Marker>.of(_markers),
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 12.0,
                  ),
                  onTap: _onTap,
                  myLocationButtonEnabled: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ValidateCoordinatesBanner(markers: _markers),
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
                        ConfirmLocationButton(markers: _markers)
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(LatLng latLng) async {
    _setMarker(latLng);
  }

  void _goToCurrentLocation() async {
    final LatLng? myLocation = await _getMyLocation();
    if (myLocation != null) {
      _setMarker(myLocation);
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

    _setMarker(LatLng(location.latitude, location.longitude));
  }

  void _setMarker(LatLng latLng) async {
    Marker marker = Marker(
      markerId: const MarkerId('searched_location'),
      position: latLng,
      infoWindow: InfoWindow(
        title: latLng.toString(),
      ),
    );

    setState(() {
      _markers.clear();
      _markers.add(marker);
    });

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        latLng,
        14,
      ),
    );
  }
}
