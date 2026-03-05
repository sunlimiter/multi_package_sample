import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:session/session.dart';

@injectable
class AuthInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      SessionManager.defaultManager.clear();
    }

    super.onError(err, handler);
  }
}
