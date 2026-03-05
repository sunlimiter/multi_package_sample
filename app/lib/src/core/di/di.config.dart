// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/src/core/analytics/app_analytics_logger.dart' as _i512;
import 'package:app/src/core/env/app_config_impl.dart' as _i982;
import 'package:auth/go_auth.dart' as _i894;
import 'package:common/common.dart' as _i107;
import 'package:get_it/get_it.dart' as _i174;
import 'package:home/go_home.dart' as _i12;
import 'package:injectable/injectable.dart' as _i526;
import 'package:message/go_message.dart' as _i971;
import 'package:profile/go_profile.dart' as _i389;
import 'package:splash/go_splash.dart' as _i858;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i107.AppConfig>(() => _i982.AppBuildConfig());
    gh.lazySingleton<_i107.AnalyticsLogger>(() => _i512.AppAnalyticsLogger());
    await _i107.NetworkPackageModule().init(gh);
    await _i107.CommonPackageModule().init(gh);
    await _i858.SplashPackageModule().init(gh);
    await _i894.AuthPackageModule().init(gh);
    await _i389.ProfilePackageModule().init(gh);
    await _i12.HomePackageModule().init(gh);
    await _i971.MessagePackageModule().init(gh);
    return this;
  }
}
