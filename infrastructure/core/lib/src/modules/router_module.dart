// ignore_for_file: one_member_abstracts

import 'package:common_dependencies/common_dependencies.dart';

class RouteMissingArgsFailure implements Exception {}

T getArgsOrThrow<T>(Object? arguments) {
  if (arguments == null) {
    throw RouteMissingArgsFailure();
  }

  return arguments as T;
}

T? tryToGetArgsOrIgnore<T>(Object? arguments) {
  if (arguments != null) {
    return arguments as T;
  }

  return null;
}

abstract class RouterModule {
  List<GoRoute> getRoutes();
}
