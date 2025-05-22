import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/loyalty_points/data/loyalty_points_repository.dart';
import 'package:widam/src/features/loyalty_points/domain/loyalty_program/loyalty_program.dart';

part 'loyalty_program_controller.g.dart';

@riverpod
class LoyaltyProgramController extends _$LoyaltyProgramController {
  @override
  FutureOr<LoyaltyProgramState> build() => const LoyaltyProgramInitial();

  Future<void> getLoyaltyProgram() async {
    state = const AsyncLoading();
    try {
      final loyaltyProgram =
          await ref.read(loyaltyPointsRepositoryProvider).getLoyaltyProgram();
      if (loyaltyProgram == null) {
        state = const AsyncData(LoyaltyProgramEmpty());
      } else {
        state = AsyncData(LoyaltyProgramLoaded(loyaltyProgram));
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

sealed class LoyaltyProgramState {
  const LoyaltyProgramState();
}

class LoyaltyProgramInitial extends LoyaltyProgramState {
  const LoyaltyProgramInitial();
}

class LoyaltyProgramLoaded extends LoyaltyProgramState {
  final LoyaltyProgram loyaltyProgram;

  const LoyaltyProgramLoaded(this.loyaltyProgram);
}

class LoyaltyProgramEmpty extends LoyaltyProgramState {
  const LoyaltyProgramEmpty();
}
