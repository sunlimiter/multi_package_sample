import 'dart:async';

import 'package:core/core.dart';
import 'package:user_center/src/router/user_center_navigator.dart';
import 'package:user_center/src/ui/mine/mine_cubit.dart';

///author: lty
////Time: 2022/10/25
////Description:

class UserCenterInjectionModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector
      ..registerLazySingleton<UserCenterNavigator>(UserCenterNavigator.new)
      ..registerFactory<MineCubit>(MineCubit.new);
    //VIEW
  }
}
