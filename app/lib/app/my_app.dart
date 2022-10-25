import 'package:common_dependencies/common_dependencies.dart';
import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final List<LocalizationsDelegate> localeDelegates;
  final List<RouterModule> routes;

  const MyApp({
    Key? key,
    required this.localeDelegates,
    required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) => generateRoute(
        settings: settings,
        routes: routes,
      ),
      builder: AuthenticationBloc.buildAuth(),
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: appSupportedLanguages,
      localizationsDelegates: localeDelegates,
      debugShowCheckedModeBanner: false,
    );
  }

  Route<dynamic>? generateRoute({
    required List<RouterModule> routes,
    required RouteSettings settings,
  }) {
    final routesMap = <String, MaterialPageRoute>{};
    for (final route in routes) {
      routesMap.addAll(route.getRoutes(settings));
    }
    return routesMap[settings.name];
  }
}
