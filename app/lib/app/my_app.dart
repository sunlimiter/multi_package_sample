import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final List<LocalizationsDelegate> localeDelegates;
  final List<RouterModule> routes;
  final String title;

  const MyApp({
    Key? key,
    required this.localeDelegates,
    required this.routes,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: generateRoute(
        routes: routes,
      ),
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: appSupportedLanguages,
      localizationsDelegates: localeDelegates,
      debugShowCheckedModeBanner: false,
    );
  }

  GoRouter generateRoute({
    required List<RouterModule> routes,
  }) {
    final routesMap = <GoRoute>[];
    for (final route in routes) {
      routesMap.addAll(route.getRoutes());
    }
    return GoRouter(
      routes: <RouteBase>[
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: routesMap,
        ),
      ],
      debugLogDiagnostics: true,
      refreshListenable: AppInjector.I.get<AuthenticationBloc>(),
      redirect: (context, state) {
        final bloc = AppInjector.I.get<AuthenticationBloc>();
        final bool signedIn = bloc.state.status == AuthenticationStatus.authenticated;
        final bool signingIn = state.subloc == LoginRoutes.root;
        final bool splashIn = state.subloc == SplashRoutes.root;
        //未登录，当前页为非登录页
        if (!signedIn && !signingIn) {
          return LoginRoutes.root;
        } else if (signedIn && (signingIn || splashIn)) {
          //已登录，当前页面为登录页面/引导页
          return HomeRoutes.root;
        }
        return null;
      },
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    return Scaffold(
      body: child,
      bottomNavigationBar: Visibility(
        visible: location == HomeRoutes.root || location == UserRoutes.root,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notification_important_rounded),
            //   label: '消息',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              label: '我的',
            ),
          ],
          currentIndex: _calculateSelectedIndex(context),
          onTap: (int idx) => _onItemTapped(idx, context),
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith(HomeRoutes.root)) {
      return 0;
    }
    if (location.startsWith(UserRoutes.root)) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(HomeRoutes.root);
        break;
      case 1:
        context.go(UserRoutes.root);
        break;
    }
  }
}
