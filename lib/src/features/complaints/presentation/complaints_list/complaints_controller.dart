import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/features/complaints/data/complaints_repository.dart';
import 'package:widam/src/features/complaints/domain/complaint/complaint.dart';

part 'complaints_controller.g.dart';

@riverpod
class ComplaintsController extends _$ComplaintsController {
  ComplaintsRepository get _complaintsRepository =>
      ref.watch(complaintsRepositoryProvider);
  @override
  FutureOr<AppResponse<List<Complaint>>> build() {
    return _complaintsRepository.getComplaints(1);
  }

  void addComplaint(Complaint complaint) {
    state = AsyncData(state.asData!.value
        .copyWith(data: [complaint, ...state.asData!.value.data]));
  }

  Future<bool> onLoading(int pageNo) async {
    if (pageNo > state.asData!.value.pagination!.totalPages) {
      return false;
    }
    try {
      final response = await _complaintsRepository.getComplaints(pageNo);
      state = AsyncData(state.asData!.value
          .copyWith(data: [...state.asData!.value.data, ...response.data]));
      return true;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      return false;
    }
  }
}
