import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

/// Interceptor to mock backend API responses using local JSON assets.
@injectable
class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Only intercept requests if running in debug mode
    if (!kDebugMode) {
      return handler.next(options);
    }

    final mockEndpoints = {
      '/api/loginByPwd': 'packages/network/assets/mock/login_success.json',
      '/api/userInfo': 'packages/network/assets/mock/user_info_success.json',
    };

    if (mockEndpoints.containsKey(options.path)) {
      try {
        final assetPath = mockEndpoints[options.path]!;
        final jsonString = await rootBundle.loadString(assetPath);
        final dynamic data = jsonDecode(jsonString);

        return handler.resolve(
          Response(
            requestOptions: options,
            data: data,
            statusCode: 200,
          ),
        );
      } catch (e) {
        debugPrint('MockInterceptor: Error loading mock data: $e');
        // If the mock parsing fails, let the error pass through
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Mock Error: Failed to load mock data for ${options.path}. $e',
          ),
        );
      }
    }

    // Pass through un-mocked requests.
    return handler.next(options);
  }
}
