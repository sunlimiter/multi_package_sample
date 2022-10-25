///author: lty
///Time: 2022/06/10
///Description:
import 'package:core/core.dart';

const analyticsLogs = bool.fromEnvironment("analyticsLogs", defaultValue: false);
const baseUrl = String.fromEnvironment("baseUrl", defaultValue: 'https://apigw.91jkys.com');
const debug = bool.fromEnvironment("debug", defaultValue: false);

class AppBuildConfig extends BuildConfig {

  @override
  Map<String, dynamic> configs = {
    'analyticsLogs': analyticsLogs,
    'baseUrl': baseUrl,
    'debug': debug,
  };
}
