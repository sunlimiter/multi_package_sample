import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:login/src/ui/login_screen.dart';

class LoginRouterModule implements RouterModule {
  @override
  List<GoRoute> getRoutes() => <GoRoute>[
        GoRoute(
          path: LoginRoutes.root,
          builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
        ),
      ];
}
