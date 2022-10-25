///author: lty
///Time: 2022/06/10
///Description:
// ignore_for_file: do_not_use_environment

import 'package:core/core.dart';

const analyticsLogs = bool.fromEnvironment('analyticsLogs');
const baseUrl = String.fromEnvironment('baseUrl', defaultValue: 'https://apigw.91jkys.com');
const debug = bool.fromEnvironment('debug');

class AppBuildConfig extends BuildConfig {
  @override
  Map<String, dynamic> configs = {
    'analyticsLogs': analyticsLogs,
    'baseUrl': baseUrl,
    'debug': debug,
  };
}
