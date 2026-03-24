//@GeneratedMicroModule;NetworkPackageModule;package:network/src/di/di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/src/di/network_module.dart' as _i1026;
import 'package:network/src/dio_http_client.dart' as _i427;
import 'package:network/src/http_client.dart' as _i118;
import 'package:network/src/interceptors/auth_interceptor.dart' as _i685;
import 'package:network/src/interceptors/mock_interceptor.dart' as _i429;
import 'package:network/src/params/network_params.dart' as _i668;

class NetworkPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final networkModule = _$NetworkModule();
    gh.factory<_i685.AuthInterceptor>(() => _i685.AuthInterceptor());
    gh.factory<_i429.MockInterceptor>(() => _i429.MockInterceptor());
    gh.lazySingleton<_i361.Dio>(
      () =>
          networkModule.provideDio(gh<_i668.NetworkParams>(), gh<_i685.AuthInterceptor>(), gh<_i429.MockInterceptor>()),
    );
    gh.lazySingleton<_i118.HttpClient>(() => _i427.DioHttpClient(gh<_i361.Dio>()));
  }
}

class _$NetworkModule extends _i1026.NetworkModule {}
