///author: lty
///Time: 2022/06/10
///Description:
// ignore_for_file: do_not_use_environment

import 'package:common/common.dart';

const analyticsLogs = bool.fromEnvironment('analyticsLogs');
const appName = String.fromEnvironment('组件化');

@Singleton(as: AppConfig)
class AppBuildConfig extends AppConfig {
  @override
  String baseUrl() => const String.fromEnvironment('BASE_URL', defaultValue: 'https://api.myapp.com');

  @override
  bool isDebug() => const bool.fromEnvironment('DEBUG', defaultValue: true);
  @override
  String appVersionName() => '1.0.0';
  @override
  int appVersionCode() => 1;
}
