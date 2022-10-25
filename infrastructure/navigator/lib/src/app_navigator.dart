import 'package:flutter/material.dart';
import 'package:common_dependencies/common_dependencies.dart';

final navigatorKey = GlobalKey<NavigatorState>();

mixin AppNavigator {
  Future<R?> navigateTo<R, A>(
    BuildContext context,
    String routeName, {
    A? arguments,
    bool pushAndReplace = false,
    String? anchor,
  }) async {
    context.go(routeName);
    if (pushAndReplace) {
      if (anchor != null) {
        return Navigator.of(context).pushNamedAndRemoveUntil<R>(
          routeName,
          (route) => route.settings.name == anchor,
          arguments: arguments,
        );
      } else {
        return Navigator.of(context).pushNamedAndRemoveUntil<R>(
          routeName,
          (route) => false,
          arguments: arguments,
        );
      }
    }

    // ignore: unnecessary_await_in_return
    return await Navigator.of(context).pushNamed<R>(
      routeName,
      arguments: arguments,
    );
  }
}
