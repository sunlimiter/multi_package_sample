import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../interceptors/auth_interceptor.dart';
import '../interceptors/mock_interceptor.dart';
import '../params/network_params.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio(NetworkParams params, AuthInterceptor authInterceptor, MockInterceptor mockInterceptor) {
    final dio = Dio();
    dio.options.baseUrl = params.baseUrl;
    dio.options.connectTimeout = Duration(milliseconds: params.connectTimeout);
    dio.options.receiveTimeout = Duration(milliseconds: params.receiveTimeout);

    dio.interceptors.add(mockInterceptor);
    dio.interceptors.add(authInterceptor);

    return dio;
  }
}
