import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_api/home_api.dart';
import 'package:splash_api/splash_api.dart';
import 'package:auth_api/auth_api.dart';
import 'scaffold_with_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final List<RouteBase> routes;
  final List<StatefulShellBranch> shellBranches;
  final List<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final String title;

  const MyApp({
    super.key,
    required this.routes,
    required this.shellBranches,
    required this.localizationsDelegates,
    this.title = 'Flutter Demo',
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  late final List<LocalizationsDelegate<dynamic>> _localizationsDelegates;

  @override
  void initState() {
    super.initState();
    _localizationsDelegates = [
      ...widget.localizationsDelegates,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

    final shellRoute = StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: widget.shellBranches,
    );

    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashRoutes.root,
      refreshListenable: SessionManager.defaultManager,
      routes: [if (widget.shellBranches.isNotEmpty) shellRoute, ...widget.routes],
      redirect: (context, state) {
        final isLoggedIn = SessionManager.defaultManager.isLogin();
        final isAuthRoute = state.matchedLocation.startsWith(AuthRoutes.root);
        final isSplashRoute = state.matchedLocation == SplashRoutes.root;

        if (isSplashRoute) {
          // Allow the splash screen to render and handle its own countdown and routing.
          return null;
        }

        if (!isLoggedIn && !isAuthRoute) {
          // If not logged in and not on an auth route, redirect to login.
          return AuthRoutes.root;
        } else if (isLoggedIn && isAuthRoute) {
          // If logged in and trying to access an auth route, redirect to home.
          return HomeRoutes.root;
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: widget.title,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      routerConfig: _router,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ],
    );
  }
}
