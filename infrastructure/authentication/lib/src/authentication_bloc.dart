///author: lty
///Time: 2022/06/01
///Description:
import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> with ChangeNotifier {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      _mapAuthenticationStatusChangedToState,
    );
  }

  final AuthenticationRepository _authenticationRepository = AppInjector.I.get();

  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void logout() {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _authenticationRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }

  Future<void> _mapAuthenticationStatusChangedToState(
    AuthenticationStatus status,
  ) async {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        var authState = user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated();
        emit(authState);
        break;
      default:
        emit(const AuthenticationState.unknown());
        break;
    }
    notifyListeners();
  }
}
