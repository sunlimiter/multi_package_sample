// ignore_for_file: one_member_abstracts

abstract class AnalyticsLogger {
  void logEvent(String name, [Map<String, String> params]);
}
