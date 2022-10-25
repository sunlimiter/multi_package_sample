import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:login/src/router/app_login_navigator.dart';
import 'package:login/src/ui/cubit/login_cubit.dart';

class LoginInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector
      // presentation
      ..registerLazySingleton<LoginNavigator>(AppLoginNavigator.new)
      ..registerFactory<LoginCubit>(LoginCubit.new);
  }
}
