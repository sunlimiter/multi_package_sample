//@GeneratedMicroModule;CommonPackageModule;package:common/src/di/di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:common/src/config/app_config.dart' as _i599;
import 'package:common/src/impl/app_network_params.dart' as _i236;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/network.dart' as _i372;

class CommonPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i372.NetworkParams>(() => _i236.AppNetworkParams(gh<_i599.AppConfig>()));
  }
}
