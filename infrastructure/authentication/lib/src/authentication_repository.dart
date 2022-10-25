///author: lty
///Time: 2022/06/01
///Description:
import 'dart:async';
import 'dart:convert';

import 'package:common_dependencies/common_dependencies.dart';

import 'user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Future<User?> getUser();

  Future<void> logIn(User user);

  Future<void> logOut();

  void dispose();

  Stream<AuthenticationStatus> get status;
}

class IAuthenticationRepository implements AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  User? _user;

  @override
  Stream<AuthenticationStatus> get status async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString('user');
    if (userJson != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  @override
  Future<void> logIn(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    _user = user;
    _controller.add(AuthenticationStatus.authenticated);
  }

  @override
  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _user = null;
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();

  @override
  Future<User?> getUser() async {
    if (_user != null) return _user;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString('user');
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }
    return _user;
  }
}
