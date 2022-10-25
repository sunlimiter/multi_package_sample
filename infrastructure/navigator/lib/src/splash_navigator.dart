// ignore_for_file: one_member_abstracts

import 'package:flutter/material.dart';

class SplashRoutes {
  SplashRoutes._();

  static const String root = '/';
}

abstract class SplashNavigator {
  void navigateToSplash(BuildContext context);
}
