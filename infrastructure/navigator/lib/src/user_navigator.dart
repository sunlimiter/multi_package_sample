import 'package:flutter/material.dart';

///author: lty
////Time: 2022/10/25
////Description:

class UserCenterRoutes {
  UserCenterRoutes._();

  static const String root = '/userCenter';
}

abstract class UserNavigator {
  void navigateToUserCenter(BuildContext context);
}
