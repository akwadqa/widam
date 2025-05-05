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
    final AppDataRepository appDataRepository =
        ref.watch(appDataRepositoryProvider);
    final AppData appData = await appDataRepository.getAppData(
        ref.read(userDataProvider) != null
            ? ref.read(localGeofenceIdProvider)!
            : ref.watch(localGeofenceIdProvider)!);
    return appData;
  }

  void updateGeofence(Geofence geofence) {
    state = AsyncData(state.asData!.value.copyWith(geofence: geofence));
  }

  Future<void> updateAddress(Address address) async {
    await ref.read(localLocationInfoProvider.notifier).setLocalLocationInfo(
        address.latitude, address.longitude, address.warehouse?.warehouseId);
    await ref
        .read(localGeofenceIdProvider.notifier)
        .setLocalGeofenceId(address.geofence!.geofenceId);
    state = AsyncData(state.asData!.value.copyWith(address: address));
  }
}
