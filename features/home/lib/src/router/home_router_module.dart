import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:home/src/ui/home_screen.dart';

class HomeRouterModule implements RouterModule {
  @override
  List<GoRoute> getRoutes() => <GoRoute>[
        GoRoute(
          path: HomeRoutes.root,
          pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: HomeScreen(),
          ),
        ),
      ];
}
