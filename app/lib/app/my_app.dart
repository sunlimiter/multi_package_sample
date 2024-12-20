import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MyApp extends HookWidget {
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
    final _localeCubit = useBloc<LocaleCubit>();

    final LocaleState _state = useBlocBuilder<LocaleCubit, LocaleState>(
      _localeCubit,
    );
    debugPrint(_state.locale.toString());
    return MaterialApp.router(
      routerConfig: generateRoute(
        routes: routes,
      ),
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      locale: _state.locale,
      // localeResolutionCallback: localeResolutionCallback,
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
        final bool signedIn =
            bloc.state.status == AuthenticationStatus.authenticated;
        final bool signingIn = state.matchedLocation == LoginRoutes.root;
        final bool splashIn = state.matchedLocation == SplashRoutes.root;
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
    final String location = route.routerDelegate.currentConfiguration.fullPath;
    return Scaffold(
      body: child,
      floatingActionButton: Visibility(
        visible: location == HomeRoutes.root || location == UserRoutes.root,
        child: FloatingActionButton(
          onPressed: () {
            _onItemTapped(1, context);
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.notification_important_rounded,
            color: getColor(context, 1),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Visibility(
        visible: location == HomeRoutes.root || location == UserRoutes.root,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    _onItemTapped(0, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: getColor(context, 0),
                        ),
                        Text(
                          '首页',
                          style: TextStyle(
                            color: getColor(context, 0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // _onItemTapped(1, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.notification_important_rounded,
                          color: Colors.transparent,
                        ),
                        Text(
                          '消息',
                          style: TextStyle(
                            color: getColor(context, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _onItemTapped(2, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.perm_identity,
                          color: getColor(context, 2),
                        ),
                        Text(
                          '我的',
                          style: TextStyle(
                            color: getColor(context, 2),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(BuildContext context, int value) {
    var page = 0;
    final GoRouter route = GoRouter.of(context);
    final String location = route.routerDelegate.currentConfiguration.fullPath;
    if (location.startsWith(HomeRoutes.root)) {
      page = 0;
    }
    if (location.startsWith(UserRoutes.root)) {
      page = 2;
    }
    return page != value
        ? Theme.of(context).unselectedWidgetColor
        : Theme.of(context).colorScheme.secondary;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(HomeRoutes.root);
        break;
      case 2:
        context.go(UserRoutes.root);
        break;
    }
  }
}
