//@GeneratedMicroModule;AuthPackageModule;package:auth/go_auth.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/src/di/auth_localization_module.dart' as _i804;
import 'package:auth/src/di/auth_navigation_module.dart' as _i788;
import 'package:auth/src/repository/auth_repository.dart' as _i281;
import 'package:auth/src/services/auth_service_impl.dart' as _i366;
import 'package:auth/src/startup/auth_initializer.dart' as _i960;
import 'package:auth/src/ui/login_cubit.dart' as _i71;
import 'package:auth_api/auth_api.dart' as _i56;
import 'package:common/common.dart' as _i107;
import 'package:injectable/injectable.dart' as _i526;

class AuthPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i107.AppInitializer>(() => _i960.AuthInitializer(), instanceName: 'Auth');
    gh.factory<_i107.IModuleLocalization>(() => _i804.AuthLocalizationModule(), instanceName: 'Auth');
    gh.factory<_i107.IModuleRouter>(() => _i788.AuthNavigationModule(), instanceName: 'Auth');
    gh.factory<_i281.AuthRepository>(() => _i281.AuthRepository(gh<_i107.HttpClient>()));
    gh.lazySingleton<_i56.IAuthService>(() => _i366.AuthServiceImpl(gh<_i281.AuthRepository>()));
    gh.factory<_i71.LoginCubit>(() => _i71.LoginCubit(gh<_i281.AuthRepository>()));
  }
}
