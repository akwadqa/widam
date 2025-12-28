import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/services_urls.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import 'package:widam/src/network/exception/dio_exceptions.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../../routing/app_router_provider.dart';

class RemoteInterceptor extends Interceptor {
  final Ref ref;
  final void Function() onUnauthorized;

  RemoteInterceptor(this.ref,{
     required this.onUnauthorized
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = ref.read(userDataProvider)?.token;
    final languageCode = ref.read(currentLanguageProvider);

  if (options.baseUrl != ServicesUrls.googleMapsBaseUrl) {
      if (token != null) {
        options.headers['Authorization'] = 'token $token';
      }
      options.headers['Accept-Language'] = languageCode;
    }

    debugPrint("🔵 [DIO REQUEST]");
    debugPrint("➡️ ${options.method} ${options.uri}");
    debugPrint("📦 Headers: ${options.headers}");
    debugPrint("📝 Body: ${options.data}");

    handler.next(options);
    // super.onRequest(options, handler);

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("🟢 [DIO RESPONSE]");
    debugPrint("✅ ${response.statusCode} ${response.requestOptions.uri}");
    debugPrint("📦 Response data: ${_prettyJson(response.data)}");

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      debugPrint(err.response!.data.toString());
    }
    final String? message = err.response?.data['message'];
    
    final statusCode = err.response?.statusCode;
    final responseData = err.response?.data;

    // ✅ تحقق من إذا كان Unauthorized
    final isUnauthorized = statusCode == 401 ||
        (responseData is Map &&
            responseData['message']?.toString().toLowerCase().contains("unauthorized") == true);

    if (isUnauthorized) {
      debugPrint("🚪 Session expired → redirect to Login");

      // 1. مسح بيانات المستخدم (التوكن)
      ref.read(userDataProvider.notifier).removeUserData();

      // 2. توجيه المستخدم لصفحة تسجيل الدخول
      ref.read(appRouterProvider).replaceAll([const LoginScreen()]);
      // لو تستخدم GoRouter:
      // ref.read(goRouterProvider).go('/login');
    }
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions, message);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, message);
          case 401:
            throw UnauthorizedException(err.requestOptions, message);
          case 403:
            onUnauthorized();
            throw AccessForbiddenException(err.requestOptions, message);
          case 404:
            throw NotFoundException(err.requestOptions, message);
          case 409:
            throw ConflictException(err.requestOptions, message);
          case 422:
            throw UnprocessableEntityException(err.requestOptions, message);
          case 500:
            throw InternalServerErrorException(err.requestOptions, message);
          default:
            throw BadResponseException(err.requestOptions, message);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions, message);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions, message);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(err.requestOptions, message);
    }
    return handler.next(err);
  }




  // String? _getDefaultMessageForStatusCode(int? status) {
  //   switch (status) {
  //     case 400:
  //       return 'Bad Request';
  //     case 401:
  //       return 'Unauthorized';
  //     case 403:
  //       return 'Forbidden';
  //     case 404:
  //       return 'Not Found';
  //     case 409:
  //       return 'Conflict';
  //     case 422:
  //       return 'Unprocessable Entity';
  //     case 500:
  //       return 'Internal Server Error';
  //     default:
  //       return null;
  //   }
  // }

  String _prettyJson(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (_) {
      return 'Invalid JSON';
    }
  }
}
