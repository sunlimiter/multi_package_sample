//@GeneratedMicroModule;SplashPackageModule;package:splash/go_splash.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:common/common.dart' as _i107;
import 'package:injectable/injectable.dart' as _i526;
import 'package:splash/src/di/splash_localization_module.dart' as _i858;
import 'package:splash/src/di/splash_navigation_module.dart' as _i803;

class SplashPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i107.IModuleLocalization>(
      () => _i858.SplashLocalizationModule(),
      instanceName: 'Splash',
    );
    gh.factory<_i107.IModuleRouter>(
      () => _i803.SplashNavigationModule(),
      instanceName: 'Splash',
    );
  }
}
