import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/address.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import '../../addresses/application/local_location_info.dart';
import '../../addresses/domain/geofence.dart';
import '../data/app_data_repository.dart';
import '../domain/app_data/app_data.dart';

part 'app_data_controller.g.dart';

@Riverpod(keepAlive: true)
class AppDataController extends _$AppDataController {
  @override
  FutureOr<AppData> build() {
    return _getAppData();
  }
   Future<AppData> _getAppData() async {
    final appDataRepository = ref.read(appDataRepositoryProvider);

    final geofenceId = ref.read(localGeofenceIdProvider);

    // if (geofenceId == null) {
    //   Error.throwWithStackTrace(
    //     StateError('FATAL: geofenceId is required to load AppData'),
    //     StackTrace.current,
    //   );
    // }

    return appDataRepository.getAppData(geofenceId??"");
  }
  // Future<AppData> _getAppData() async {
  //   final appDataRepository = ref.read(appDataRepositoryProvider);

  //   final geofenceId = ref.read(localGeofenceIdProvider);

  //   if (geofenceId == null) {
  //     throw Exception('Missing geofenceId');
  //   }

  //   // final userData = ref.read(userDataProvider);

  //   // if (userData == null) {
  //   //   throw Exception('User is not authenticated');
  //   // }

  //   return appDataRepository.getAppData(geofenceId);
  // }
    void updateGeofence(Geofence geofence) {
    final current = state.value;

    if (current == null) return;

    state = AsyncData(
      current.copyWith(geofence: geofence),
    );
  }

  Future<void> updateAddress(Address address) async {
    await ref
        .read(localLocationInfoProvider.notifier)
        .setLocalLocationInfo(
          address.latitude,
          address.longitude,
          address.warehouse?.warehouseId,
        );

    await ref
        .read(localGeofenceIdProvider.notifier)
        .setLocalGeofenceId(
          address.geofence!.geofenceId,
        );

    final current = state.value;

    if (current != null) {
      state = AsyncData(
        current.copyWith(address: address),
      );
    }
  }

  // Future<AppData> _getAppData() async {
  //   final AppDataRepository appDataRepository =
  //       ref.watch(appDataRepositoryProvider);
  //       final geofenceId = ref.watch(localGeofenceIdProvider);

  // if (geofenceId == null) {
  //   return Future.error("Missing geofenceId");
  // }

  // return appDataRepository.getAppData(geofenceId);
  //   // final AppData appData = await appDataRepository.getAppData(
  //   //     ref.read(userDataProvider) != null
  //   //         ? ref.read(localGeofenceIdProvider)!
  //   //         : ref.watch(localGeofenceIdProvider)!);
  //   // return appData;
  // }

  // void updateGeofence(Geofence geofence) {
  //   state = AsyncData(state.asData!.value.copyWith(geofence: geofence));
  // }

  // Future<void> updateAddress(Address address) async {
  //   await ref.read(localLocationInfoProvider.notifier).setLocalLocationInfo(
  //       address.latitude, address.longitude, address.warehouse?.warehouseId);
  //   await ref
  //       .read(localGeofenceIdProvider.notifier)
  //       .setLocalGeofenceId(address.geofence!.geofenceId);
  //   state = AsyncData(state.asData!.value.copyWith(address: address));
  // }
}
