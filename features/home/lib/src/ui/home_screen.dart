import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:home/src/localization/home_localization.dart';
import 'package:home/src/ui/cubit/home_cubit.dart';
import 'package:home/src/ui/cubit/home_state.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = useBloc<HomeCubit>();
    final HomeState _state = useBlocBuilder<HomeCubit, HomeState>(
      _cubit,
    );
    final _intl = HomeLocalization.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${_intl?.title}'),
            Text(_state.username),
            ElevatedButton(
              onPressed: _cubit.logout,
              child: Text('${_intl?.logout}'),
            ),
          ],
        ),
      ),
    );
  }
}
