import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/features/complaints/data/complaints_repository.dart';
import 'package:widam/src/features/complaints/domain/complaint/complaint.dart';

part 'send_complaint_controller.g.dart';

@riverpod
class SendComplaintController extends _$SendComplaintController {
  @override
  FutureOr<Complaint?> build() => null;

  Future<void> sendComplaint(
      {required String complaintType,
      required String description,
      required String subject}) async {
    state = const AsyncLoading();
    final complaintsRepository = ref.watch(complaintsRepositoryProvider);
    state = await AsyncValue.guard(() => complaintsRepository.sendComplaint(
        complaintType: complaintType,
        description: description,
        subject: subject));
  }
}
