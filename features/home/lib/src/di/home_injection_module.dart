import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:home/src/router/app_home_navigator.dart';
import 'package:home/src/ui/cubit/home_cubit.dart';

class HomeInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector
      ..registerLazySingleton<HomeNavigator>(AppHomeNavigator.new)
      ..registerFactory<HomeCubit>(HomeCubit.new);
  }
}
