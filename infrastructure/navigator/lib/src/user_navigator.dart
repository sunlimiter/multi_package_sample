// ignore_for_file: one_member_abstracts

import 'package:flutter/material.dart';

///author: lty
////Time: 2022/10/25
////Description:

class UserRoutes {
  UserRoutes._();

  static const String root = '/userCenter';
}

abstract class UserNavigator {
  void navigateToUserCenter(BuildContext context);
}
