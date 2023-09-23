import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/validate_coordinates_repository.dart';
import '../../../domain/location/location.dart';

class ValidateCoordinatesNotifier
    extends StateNotifier<ValidateCoordinatesState> {
  ValidateCoordinatesNotifier(this._ref)
      : super(const ValidateCoordinatesInitial());

  final AutoDisposeStateNotifierProviderRef<ValidateCoordinatesNotifier,
      ValidateCoordinatesState> _ref;

  Future<void> validateCoordinates(
      {double? latitude,
      double? longitude,
      required LoadingType loadingType}) async {
    state = ValidateCoordinatesLoading(loadingType);
    try {
      final location = await _ref
          .read(validateCoordinatesRepositoryProvider)
          .validateCoordinates(latitude: latitude, longitude: longitude);
      state = ValidateCoordinatesLoaded(location);
    } catch (e, stack) {
      state = ValidateCoordinatesError(e, stack);
    }
  }
}

final validateCoordinatesProvider = StateNotifierProvider.autoDispose<
    ValidateCoordinatesNotifier,
    ValidateCoordinatesState>((ref) => ValidateCoordinatesNotifier(ref));

abstract class ValidateCoordinatesState {
  const ValidateCoordinatesState();
}

class ValidateCoordinatesInitial extends ValidateCoordinatesState {
  const ValidateCoordinatesInitial();
}

enum LoadingType { skip, confirm }

class ValidateCoordinatesLoading extends ValidateCoordinatesState {
  final LoadingType loadingType;
  const ValidateCoordinatesLoading(this.loadingType);
}

class ValidateCoordinatesLoaded extends ValidateCoordinatesState {
  final Location location;
  const ValidateCoordinatesLoaded(this.location);
}

class ValidateCoordinatesError extends ValidateCoordinatesState {
  final Object error;
  final StackTrace stackTrace;
  const ValidateCoordinatesError(this.error, this.stackTrace);
}
