import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:user_center/src/ui/mine/mine_screen.dart';

///author: lty
////Time: 2022/10/25
////Description:

class UserCenterRouterModule implements RouterModule {
  @override
  List<GoRoute> getRoutes() => <GoRoute>[
        GoRoute(
          path: UserCenterRoutes.root,
          pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const MineScreen(),
          ),
        ),
      ];
}
