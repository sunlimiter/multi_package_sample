import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppAnalyticsReceiver implements AnalyticsLogger {
  AppAnalyticsReceiver();

  @override
  void logEvent(String name, [Map<String, String>? params]) {
    debugPrint(name);
  }
}
