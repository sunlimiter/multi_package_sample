import 'package:core/core.dart';
import 'package:componentized/di/module/app_library_module.dart';

class LibraryResolver extends FeatureResolver {
  @override
  InjectionModule get injectionModule => AppLibraryModule();
}
