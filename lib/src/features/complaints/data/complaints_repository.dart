import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/end_points.dart';
import 'package:widam/src/features/complaints/domain/complaint/complaint.dart';
import 'package:widam/src/network/network_service.dart';

part 'complaints_repository.g.dart';

@riverpod
ComplaintsRepository complaintsRepository(ComplaintsRepositoryRef ref) {
  return ComplaintsRepository(ref.watch(networkServiceProvider()));
}

class ComplaintsRepository {
  final NetworkService _networkService;

  ComplaintsRepository(this._networkService);

  Future<Complaint> sendComplaint(
      {required String complaintType,
      required String description,
      required String subject}) async {
    final data = FormData.fromMap({
      'issue_type': complaintType,
      'description': description,
      'subject': subject,
    });
    final response = await _networkService.post(EndPoints.complaints, data);
    final AppResponse<Complaint> appDataResponse =
        AppResponse.fromJson(response.data, (json) => Complaint.fromJson(json));
    if (appDataResponse.error == 1) {
      throw AppException(appDataResponse.message);
    }
    return appDataResponse.data;
  }

  Future<AppResponse<List<Complaint>>> getComplaints(int pageNo) async {
    final response =
        await _networkService.get(EndPoints.complaints, queryParameters: {
      'page_no': pageNo,
    });

    AppResponse<List<Complaint>> appResponse = AppResponse.fromJson(
        response.data,
        (json) => json
            .map<Complaint>((complaint) => Complaint.fromJson(complaint))
            .toList());

    if (appResponse.error == 1) {
      throw AppException(appResponse.message);
    }

    return appResponse;
  }
}
