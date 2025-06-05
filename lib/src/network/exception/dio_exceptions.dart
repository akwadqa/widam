import 'package:dio/dio.dart';

import '../../../generated/l10n.dart';

abstract class DioExceptionHandler {
  static DioException handle(DioException e) {
    final message = e.response?.data['message'];

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(e.requestOptions, message);
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(e.requestOptions, message);
          case 401:
            throw UnauthorizedException(e.requestOptions, message);
          case 403:
            throw AccessForbiddenException(e.requestOptions, message);
          case 404:
            throw NotFoundException(e.requestOptions, message);
          case 409:
            throw ConflictException(e.requestOptions, message);
          case 422:
            throw UnprocessableEntityException(e.requestOptions, message);
          case 500:
            throw InternalServerErrorException(e.requestOptions, message);
          default:
            throw BadResponseException(e.requestOptions, message);
        }
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(e.requestOptions, message);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(e.requestOptions, message);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(e.requestOptions, message);
    }
  }
}

// Base AppException
class AppException implements Exception {
  final String? message;
  AppException([this.message]);

  @override
  String toString() => message ?? 'Something went wrong';
}

// Dio-based API exception
class ApiException extends DioException {
  final String? customMessage;

  ApiException(RequestOptions r, [this.customMessage])
      : super(requestOptions: r, error: customMessage);

  String get defaultMessage => S.current.requestError;
  @override
  String toString() => customMessage ?? defaultMessage;
}

// Specific exceptions
class BadRequestException extends ApiException {
  BadRequestException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.badRequest;
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.r, [super.message]);
  @override
  String get defaultMessage =>  S.current.unauthorized;
}

class AccessForbiddenException extends ApiException {
  AccessForbiddenException(super.r, [super.message]);
  @override
  String get defaultMessage =>  S.current.accessForbidden;
}

class NotFoundException extends ApiException {
  NotFoundException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.notFound;
}

class ConflictException extends ApiException {
  ConflictException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.conflictConnection;
}

class UnprocessableEntityException extends ApiException {
  UnprocessableEntityException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.unprocessableEntity;
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.internalServerError;
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException(super.r, [super.message]);
  @override
  String get defaultMessage =>S.current.noInternetConnection;
}

class DeadlineExceededException extends ApiException {
  DeadlineExceededException(super.r, [super.message]);
  @override
  String get defaultMessage =>  S.current.connectionError;
}

class BadCertificateException extends ApiException {
  BadCertificateException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.badCertificate;
}

class ConnectionErrorException extends ApiException {
  ConnectionErrorException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.connectionError;
}

class BadResponseException extends ApiException {
  BadResponseException(super.r, [super.message]);
  @override
  String get defaultMessage => S.current.freiendlyErrorMessage;
}
