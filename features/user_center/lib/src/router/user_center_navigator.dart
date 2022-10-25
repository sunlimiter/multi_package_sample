import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';

///author: lty
////Time: 2022/10/25
////Description:
class UserCenterRoutes implements UserRoutes {
  static const String setting = 'userSetting';
}

class UserCenterNavigator with AppNavigator implements UserNavigator {
  @override
  void navigateToUserCenter(BuildContext context) => replace(context, UserRoutes.root);
}
