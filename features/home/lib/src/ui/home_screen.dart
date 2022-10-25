import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:home/src/localization/home_localization.dart';
import 'package:common_dependencies/common_dependencies.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() {
      AuthenticationBloc _bloc = AppInjector.I.get();
      return _bloc;
    });

    final _context = useContext();
    final _intl = HomeLocalization.of(_context);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${_intl?.title}'),
            Builder(
              builder: (context) {
                final userId = bloc.state.user.userModel?.userInfo?.userId;
                return Text('UserID: $userId');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                bloc.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
