import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';

///author: lty
////Time: 2022/10/25
////Description:
class AppSignInNavigator with AppNavigator implements SplashNavigator {
  @override
  void navigateToSplash(BuildContext context) => replace(context, SplashRoutes.root);
}
