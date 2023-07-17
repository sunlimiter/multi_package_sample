import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home/home.dart';
import 'package:login/login.dart';
import 'package:componentized/app/my_app.dart';
import 'package:componentized/di/app_component.dart';
import 'package:componentized/resolvers/app_resolver.dart';
import 'package:componentized/resolvers/library_resolver.dart';
import 'package:splash/go_splash.dart';
import 'package:user_center/user_center.dart';

abstract class AppStart {
  final BuildConfig buildConfig;

  /// 初始化的顺序很重要，确保你的lib包在他之前初始化，
  /// 否则你最终会得到来自 gitIt 容器的异常。
  /// The order of initialization matters, make sure that the deps of you
  /// package were initialized before him, otherwhise you will end up with
  /// a exception from gitIt container.
  final resolvers = <FeatureResolver>[
    LibraryResolver(),

    // Features
    SplashResolver(),
    HomeResolver(),
    LoginResolver(),
    UserCenterResolver(),

    // App
    AppResolver(),
  ];

  AppStart(this.buildConfig);

  Future<void> startApp() async {
    // WidgetsFlutterBinding.ensureInitialized();

    final routerModules = <RouterModule>[];

    final delegates = <LocalizationsDelegate>[
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
    final injections = <InjectionModule>[];

    for (final resolver in resolvers) {
      if (resolver.routerModule != null) {
        routerModules.add(resolver.routerModule!);
      }

      if (resolver.localeDelegate != null) {
        delegates.add(resolver.localeDelegate!);
      }

      if (resolver.injectionModule != null) {
        injections.add(resolver.injectionModule!);
      }
    }

    await AppInjectionComponent.instance.registerModules(
      config: buildConfig,
      modules: injections,
    );

    await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        runApp(
          HookedBlocConfigProvider(
            injector: () => <T extends Object>() => AppInjector.I.get<T>(),
            child: MyApp(
              routes: routerModules,
              localeDelegates: delegates,
              title: buildConfig.getString('appName') ?? '',
            ),
          ),
        );
      },
      (_, __) {},
    );
  }
}
