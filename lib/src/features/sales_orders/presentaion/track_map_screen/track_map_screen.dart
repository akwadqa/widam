import 'package:auto_route/annotations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/src/common_widgets/app_close_button.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../theme/app_colors.dart';

@RoutePage()
class TrackMapScreen extends StatelessWidget {
  const TrackMapScreen({super.key, required this.salesOrder});

  final SalesOrder salesOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _RealTimeMap(salesOrder: salesOrder),
          const PositionedDirectional(
              top: 60, start: 20, child: AppCloseButton())
        ],
      ),
    );
  }
}

class _RealTimeMap extends StatelessWidget {
  const _RealTimeMap({required this.salesOrder});

  final SalesOrder salesOrder;

  @override
  Widget build(BuildContext context) {
    final usersQuery = FirebaseDatabase.instance.ref(
        'users/${salesOrder.address.customerId}/orders/${salesOrder.salesOrderId}');
    return FirebaseDatabaseQueryBuilder(
      query: usersQuery,
      builder: (context, snapshot, _) {
        if (snapshot.hasError) {
          return AppBanner(
              message: snapshot.error.toString(),
              stackTrace: snapshot.stackTrace);
        }
        if (snapshot.hasData) {
          LatLng driverLocation;
          if (snapshot.docs.isEmpty) {
            driverLocation = LatLng(
                double.parse(salesOrder.deliveryTrip!.driverAddress.latitude),
                double.parse(salesOrder.deliveryTrip!.driverAddress.longitude));
          } else {
            driverLocation = LatLng(
                double.parse(snapshot.docs.last.value.toString()),
                double.parse(snapshot.docs.first.value.toString()));
          }
          return _Map(
              customerLocation: LatLng(
                  double.parse(salesOrder.address.latitude),
                  double.parse(salesOrder.address.longitude)),
              driverLocation: driverLocation);
        }
        return const FadeCircleLoadingIndicator();
      },
    );
  }
}

class _Map extends StatefulWidget {
  const _Map({required this.customerLocation, required this.driverLocation});
  final LatLng customerLocation;
  final LatLng driverLocation;

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  Set<Marker>? _markers;

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  void _getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Keys.googleAPIKey,
      PointLatLng(
          widget.driverLocation.latitude, widget.driverLocation.longitude),
      PointLatLng(
          widget.customerLocation.latitude, widget.customerLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine(polylineCoordinates);
  }

  void _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColors.primary,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _setMarkers;
    _getDirections();
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.customerLocation,
        zoom: 14,
      ),
      markers: _markers ?? {},
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

  Future<void> get _setMarkers async {
    final markerIcon =
        await Assets.icons.locationMarkerIcon.svg().toBitmapDescriptor();
    final driverMarkerIcon =
        await Assets.icons.driverMarkerIcon.svg().toBitmapDescriptor();
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('1'),
          position: widget.customerLocation,
          icon: markerIcon,
        ),
        Marker(
          markerId: const MarkerId('2'),
          position: widget.driverLocation,
          icon: driverMarkerIcon,
        ),
      };
    });
  }
}
