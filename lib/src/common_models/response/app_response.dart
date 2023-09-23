import 'pagination.dart';

class AppResponse<T> {
  final int statusCode;
  final int error;
  final String message;
  final Pagination? pagination;
  final T data;

  AppResponse(
      {required this.statusCode,
      required this.error,
      required this.message,
      required this.pagination,
      required this.data});

  factory AppResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    return AppResponse<T>(
      statusCode: json['status_code'],
      error: json['error'],
      message: json['message'],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      data: json['data'] != null ? create(json['data']) : null,
    );
  }

  AppResponse<T> copyWith({
    int? statusCode,
    int? error,
    String? message,
    Pagination? pagination,
    T? data,
  }) {
    return AppResponse<T>(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      message: message ?? this.message,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }
}
