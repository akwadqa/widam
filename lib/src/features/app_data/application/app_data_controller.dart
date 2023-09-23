import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/address.dart';
import '../../addresses/application/geofence_id_controller.dart';
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
    final AppData appData = await appDataRepository
        .getAppData(ref.watch(geofenceIdAndCoordinatesProvider).geofenceId!);
    return appData;
  }

  void updateGeofence(Geofence geofence) {
    state = AsyncData(state.asData!.value.copyWith(geofence: geofence));
  }

  void updateAddress(Address address) {
    state = AsyncData(state.asData!.value.copyWith(address: address));
  }
}
