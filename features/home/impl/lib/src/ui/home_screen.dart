import 'package:common/common.dart';
import 'package:flutter/material.dart';
import '../localization/home_localizations.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.home_title ?? 'Home')),
      body: Center(
        child: Text(AppLocalizations.of(context)?.home_screen ?? 'Home Screen'),
      ),
    );
  }
}
