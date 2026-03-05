import 'package:flutter/material.dart';

abstract class IModuleLocalization {
  /// 返回该模块生成的 LocalizationDelegate
  LocalizationsDelegate<dynamic> get delegate;
}
