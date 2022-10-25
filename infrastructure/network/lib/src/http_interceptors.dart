import 'dart:io';

import 'package:authentication/authentication.dart';
import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';

///author: lty
///Time: 2020/4/2
///Description:
class HttpInterceptors extends InterceptorsWrapper {
  String? appInfo;

  String getHeaderAppInfo(PackageInfo? packageInfo) {
    var appInfo = '';
    appInfo = 'zhiyun_patient;version=${packageInfo?.version};platform=';
    if (Platform.isAndroid) {
      appInfo = '${appInfo}ANDROID';
    } else if (Platform.isIOS) {
      appInfo = '${appInfo}IOS';
    }
    return appInfo;
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (appInfo == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appInfo = getHeaderAppInfo(packageInfo);
    }
    var user = await AppInjector.I.get<AuthenticationRepository>().getUser();

    options.headers.addAll({
      'Accept': 'application/json; charset=UTF-8',
      'App-Info': appInfo,
      'Device-Id': '',
      'Token': user?.userModel?.token ?? '',
    });
    return super.onRequest(options, handler);
  }

// DioError resultError(DioError e)  {
//   Response errorResponse;
//   if (e.response != null) {
//     errorResponse = e.response;
//   } else {
//     errorResponse = Response(statusCode: 666, data: {'ok': false},requestOptions:e.requestOptions);
//   }
//   if (errorResponse.statusCode == 401) {
//     AppUtils.doAppLogout('http_api 401');
//   }
//   DioError dioError = DioError(requestOptions:e.requestOptions,response: errorResponse,type:e.type,error:e.error);
//
//   return dioError;
// }
//
// ///获取授权token
// Future<String> getAuthorization() async {
//   String token = UserStore.to.token;
//   if (token == null) {
//     return "anonymous";
//   } else {
//     return token;
//   }
// }
//
// Future<String> getUserId() async {
//   int userId = UserStore.to.user?.userInfo?.userId;
//   if (userId == null) {
//     return "-1000";
//   } else {
//     return "$userId";
//   }
// }
}
