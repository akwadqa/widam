import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/constants/services_urls.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:widam/src/network/services/dio_remote_interceptor.dart';

import 'network_service.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  // const timeout = Duration(seconds: 120);

  final dio = Dio(BaseOptions(
    baseUrl: ServicesUrls.baseUrl,
    // connectTimeout: timeout,
    // receiveTimeout: timeout,
    // sendTimeout: timeout,
  ));
  // dio.interceptors.add(RemoteInterceptor(ref));
  dio.interceptors.addAll([
    RemoteInterceptor(ref,
        onUnauthorized: ref.read(userDataProvider.notifier).removeUserData),
    // Your custom logic for token, language, error mapping
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  ]);

  return dio;
}

/// NetworkService injection
@Riverpod(keepAlive: true)
NetworkService networkService(Ref ref, [Dio? dio]) =>
    DioNetworkService(dio ?? ref.watch(dioProvider));
