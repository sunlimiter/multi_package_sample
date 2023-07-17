import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:home/src/localization/home_localizations.dart';
import 'package:home/src/ui/cubit/home_cubit.dart';
import 'package:home/src/ui/cubit/home_state.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = useBloc<HomeCubit>();
    final HomeState _state = useBlocBuilder<HomeCubit, HomeState>(
      _cubit,
    );
    final _intl = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.orange.shade900,
                Colors.orange.shade800,
                Colors.orange.shade400,
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${_intl?.home_screen_title}'),
            Text(_state.username),
            ElevatedButton(
              onPressed: _cubit.logout,
              child: Text('${_intl?.home_screen_logout}'),
            ),
            ElevatedButton(
              onPressed: () {
                // 切换语言为西班牙语（西班牙）
                _cubit.changeLocale(const Locale('zh', 'CH'));
              },
              child: const Text('切换中文'),
            ),
            ElevatedButton(
              onPressed: () {
                // 切换语言为英语（美国）
                _cubit.changeLocale(const Locale('en', 'US'));
              },
              child: const Text('Switch to English'),
            ),
          ],
        ),
      ),
    );
  }
}
