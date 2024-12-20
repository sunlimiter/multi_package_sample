import 'dart:io';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:network/src/result.dart';

///author: lty
///Time: 2020/4/2
///Description: 接口请求公共参数&登录失效处理
///刷新token逻辑参考：https://gist.github.com/TimurMukhortov/a1c9819e3779015e54bc3964b7d2308a
class HttpInterceptors extends QueuedInterceptorsWrapper {
  String? appInfo;

  Future<String> getHeaderAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var os = 'flutter';
    if (Platform.isAndroid) {
      os = 'android';
    } else if (Platform.isIOS) {
      os = 'ios';
    }
    return 'version=${packageInfo.version};platform=$os';
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    appInfo ??= await getHeaderAppInfo();
    var user = await AppInjector.I.get<AuthenticationRepository>().getUser();
    var token = user?.userModel?.accessToken ?? '';
    if (token.isNotEmpty) {
      token = 'Bearer $token';
    }

    options.headers.addAll({
      'App-Info': appInfo,
      'Authorization': token,
    });
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AppInjector.I.get<AuthenticationRepository>().logOut();
    }
    handler.resolve(Response(requestOptions: err.requestOptions, data: ResultData(ok: false, error: ResultData.GlobleError).toJson()));
    // super.onError(err, handler);
  }
}
