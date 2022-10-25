import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:splash/src/ui/splash_screen.dart';

class SplashRouterModule implements RouterModule {
  @override
  List<GoRoute> getRoutes() => <GoRoute>[
        GoRoute(
          path: SplashRoutes.root,
          builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
        ),
      ];
}
