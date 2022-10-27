///author: lty
///Time: 2022/06/10
///Description:
// ignore_for_file: do_not_use_environment

import 'package:core/core.dart';

const analyticsLogs = bool.fromEnvironment('analyticsLogs');
const appName = String.fromEnvironment('组件化');
const baseUrl = String.fromEnvironment('baseUrl', defaultValue: 'https://www.fastmock.site/mock/a7a08e854dfabdb56275bfec558a8be3');
const debug = bool.fromEnvironment('debug');

class AppBuildConfig extends BuildConfig {
  @override
  Map<String, dynamic> configs = {
    'analyticsLogs': analyticsLogs,
    'baseUrl': baseUrl,
    'debug': debug,
    'appName': appName,
  };
}
