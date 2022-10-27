// ignore_for_file: one_member_abstracts
///author: lty
////Time: 2022/10/26
////Description: 埋点接口
abstract class AnalyticsLogger {
  void logEvent(String name, [Map<String, String> params]);
}
