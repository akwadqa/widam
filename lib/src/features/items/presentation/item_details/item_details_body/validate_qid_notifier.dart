import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'quantity_form_field.dart';

import '../../../data/item_details_repository.dart';

class ValidateQidNotifier extends StateNotifier<ValidateQidState> {
  final StateNotifierProviderRef<ValidateQidNotifier, ValidateQidState> _ref;

  ValidateQidNotifier(this._ref) : super(const ValidateQidInitial()) {
    _ref.listen(quantityProvider, (prev, next) {
      if (state is ValidateQidLoaded) {
        discard();
      }
    });
  }

  void discard() {
    state = const ValidateQidInitial();
  }

  Future<void> validateQid(
      {required String qid, required String mubadaraId}) async {
    state = const ValidateQidLoading();
    try {
      final data = await _ref
          .read(itemDetailsRepositoryProvider)
          .validateQid(
              qid: qid,
              mubadaraId: mubadaraId,
              quantity: _ref.read(quantityProvider));
      state = ValidateQidLoaded(data.isValid, data.message);
    } catch (error, stackTrace) {
      state = ValidateQidError(error, stackTrace);
    }
  }
}

final validateQidNotifierProvider =
    StateNotifierProvider.autoDispose<ValidateQidNotifier, ValidateQidState>(
        (ref) {
  return ValidateQidNotifier(ref);
});

abstract class ValidateQidState {
  const ValidateQidState();
}

class ValidateQidInitial extends ValidateQidState {
  const ValidateQidInitial();
}

class ValidateQidLoading extends ValidateQidState {
  const ValidateQidLoading();
}

class ValidateQidError extends ValidateQidState {
  final Object error;
  final StackTrace stackTrace;
  const ValidateQidError(this.error, this.stackTrace);
}

class ValidateQidLoaded extends ValidateQidState {
  final bool isQidValid;
  final String message;
  const ValidateQidLoaded(this.isQidValid, this.message);
}
