import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';

mixin AppNavigator {
  Future<void> navigateTo<R, A>(
    BuildContext context,
    String routeName, {
    A? arguments,
    bool pushAndReplace = false,
    String? anchor,
  }) async {
    if (pushAndReplace) {
      if (anchor != null) {
        context.goNamed(
          routeName,
        );
      } else {
        context.replace(
          routeName,
        );
      }
    }
    context.go(
      routeName,
    );
    // if (pushAndReplace) {
    //   if (anchor != null) {
    //     return Navigator.of(context).pushNamedAndRemoveUntil<R>(
    //       routeName,
    //       (route) => route.settings.name == anchor,
    //       arguments: arguments,
    //     );
    //   } else {
    //     return Navigator.of(context).pushNamedAndRemoveUntil<R>(
    //       routeName,
    //       (route) => false,
    //       arguments: arguments,
    //     );
    //   }
    // }

    // // ignore: unnecessary_await_in_return
    // return await Navigator.of(context).pushNamed<R>(
    //   routeName,
    //   arguments: arguments,
    // );
  }

  /// Navigate to a location.
  void go(BuildContext context, String location, {Object? extra}) =>
      context.go(location, extra: extra);

  /// Navigate to a named route.
  void goNamed(
    BuildContext context,
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.goNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  void push(BuildContext context, String location, {Object? extra}) =>
      context.push(location, extra: extra);

  void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.pushNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  void replace(BuildContext context, String location, {Object? extra}) =>
      context.replace(location, extra: extra);

  void replaceNamed(
    BuildContext context,
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.replaceNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );
}
