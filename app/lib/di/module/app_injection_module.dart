import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:componentized/analytics/app_analytics_receiver.dart';

class AppInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector
      ..registerSingleton<AnalyticsLogger>(AppAnalyticsReceiver())
      ..registerSingleton<BuildConfig>(buildConfig)
      ..registerLazySingleton<AuthenticationRepository>(IAuthenticationRepository.new)
      ..registerLazySingleton<AuthenticationBloc>(AuthenticationBloc.new)
      ..registerLazySingleton<LocaleRepository>(ILocaleRepository.new)
      ..registerLazySingleton<LocaleCubit>(LocaleCubit.new);
  }
}
