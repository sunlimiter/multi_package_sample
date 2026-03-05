//@GeneratedMicroModule;ProfilePackageModule;package:profile/go_profile.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:common/common.dart' as _i107;
import 'package:injectable/injectable.dart' as _i526;
import 'package:profile/src/di/profile_localization_module.dart' as _i446;
import 'package:profile/src/di/profile_navigation_module.dart' as _i267;
import 'package:profile/src/ui/profile/profile_cubit.dart' as _i736;
import 'package:profile/src/ui/settings/settings_cubit.dart' as _i703;

class ProfilePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i703.SettingsCubit>(() => _i703.SettingsCubit());
    gh.factory<_i107.IModuleLocalization>(
      () => _i446.ProfileLocalizationModule(),
      instanceName: 'Profile',
    );
    gh.factory<_i107.IModuleRouter>(
      () => _i267.ProfileNavigationModule(),
      instanceName: 'Profile',
    );
    gh.factory<_i736.ProfileCubit>(
        () => _i736.ProfileCubit(gh<_i107.HttpClient>()));
  }
}
