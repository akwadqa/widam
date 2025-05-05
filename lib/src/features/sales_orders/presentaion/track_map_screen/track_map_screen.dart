import 'package:auto_route/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/src/common_widgets/app_close_button.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/constants/keys.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/addresses/domain/address/address.dart';
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../theme/app_colors.dart';

part 'track_map_screen.g.dart';

@Riverpod(keepAlive: true)
FutureOr<String?> firebaseUid(FirebaseUidRef ref) async {
  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: Strings.firebaseUserEmail,
    password: Strings.firebaseUserPassword,
  );
  return userCredential.user?.uid;
}

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

class _RealTimeMap extends ConsumerWidget {
  const _RealTimeMap({required this.salesOrder});

  final SalesOrder salesOrder;

  LatLng _getLatLngFromAddress(Address address) {
    return LatLng(
      double.parse(address.latitude),
      double.parse(address.longitude),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerLocation = _getLatLngFromAddress(salesOrder.address);
    final driverAddress = salesOrder.deliveryTrip!.driverAddress;
    final driverLocation = _getLatLngFromAddress(driverAddress);
    final uid = ref.watch(firebaseUidProvider).asData?.value;
    final query = uid != null
        ? FirebaseDatabase.instance.ref(
            'users/$uid/users/${salesOrder.address.customerId}/orders/${salesOrder.salesOrderId}')
        : null;
    return query == null
        ? _Map(
            query: query,
            customerLocation: customerLocation,
            driverLocation: driverLocation,
          )
        : _buildRealTimeMap(customerLocation, driverLocation, query);
  }

  Widget _buildRealTimeMap(LatLng customerLocation, LatLng driverLocation,
      DatabaseReference? query) {
    return FirebaseDatabaseQueryBuilder(
      query: query!,
      builder: (context, snapshot, _) {
        if (snapshot.hasError) {
          return AppBanner(
            message: snapshot.error.toString(),
            stackTrace: snapshot.stackTrace,
          );
        }

        if (snapshot.hasData) {
          return _Map(
            query: query,
            customerLocation: customerLocation,
            driverLocation:
                _getDriverLocationFromSnapshot(snapshot, driverLocation),
          );
        }

        return const FadeCircleLoadingIndicator();
      },
    );
  }

  LatLng _getDriverLocationFromSnapshot(
      FirebaseQueryBuilderSnapshot snapshot, LatLng defaultLocation) {
    if (snapshot.docs.isEmpty) return defaultLocation;

    return LatLng(
      double.parse(snapshot.docs
          .firstWhere((element) => element.key == 'lat')
          .value
          .toString()),
      double.parse(snapshot.docs
          .firstWhere((element) => element.key == 'long')
          .value
          .toString()),
    );
  }
}

class _Map extends StatefulWidget {
  const _Map(
      {required this.customerLocation,
      required this.driverLocation,
      required this.query});
  final LatLng customerLocation;
  final LatLng driverLocation;
  final DatabaseReference? query;

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
  void initState() {
    if (widget.query != null) {
      widget.query!.onValue.listen((_) {
        Future(() {
          _setMarkers;
          _getDirections();
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
