import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:user_center/src/router/user_center_navigator.dart';
import 'package:user_center/src/ui/mine/mine_screen.dart';
import 'package:user_center/src/ui/setting/setting_screen.dart';

///author: lty
////Time: 2022/10/25
////Description:

class UserCenterRouterModule implements RouterModule {
  @override
  List<GoRoute> getRoutes() => <GoRoute>[
        GoRoute(
            path: UserRoutes.root,
            pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const MineScreen(),
                ),
            routes: <RouteBase>[
              GoRoute(
                path: UserCenterRoutes.setting,
                builder: (BuildContext context, GoRouterState state) => const SettingScreen(),
              ),
            ]),
      ];
}
