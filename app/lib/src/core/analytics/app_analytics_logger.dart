import 'package:common/common.dart';
import 'package:flutter/foundation.dart';

@LazySingleton(as: AnalyticsLogger)
class AppAnalyticsLogger implements AnalyticsLogger {
  @override
  void logEvent(String name, [Map<String, String>? params]) {
    debugPrint(' Analytics Event: $name | Params: $params');
    // Here you would integrate with Firebase Analytics, Mixpanel, etc.
  }
}
