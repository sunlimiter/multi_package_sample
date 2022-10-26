import 'package:core/core.dart';

import 'package:componentized/di/module/app_injection_module.dart';

class AppResolver extends FeatureResolver {
  @override
  InjectionModule get injectionModule => AppInjectionModule();
}
