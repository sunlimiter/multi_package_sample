///author: lty
///Time: 2022/06/01
///Description:
import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'authentication_repository.dart';
import 'user.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => _mapAuthenticationStatusChangedToState(status),
    );
  }

  final AuthenticationRepository _authenticationRepository = AppInjector.I.get();

  NavigatorState? get navigator => navigatorKey.currentState;

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

  Future<void> _mapAuthenticationStatusChangedToState(AuthenticationStatus status) async {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        emit(AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        var authState = user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated();
        emit(authState);
        break;
      default:
        emit(AuthenticationState.unknown());
        break;
    }
  }

  static TransitionBuilder buildAuth() {
    return (context, child) {
      return HookBuilder(builder: (_) {
        final bloc = useBloc<AuthenticationBloc>();
        useBlocListener<AuthenticationBloc,AuthenticationState>(bloc, (_, AuthenticationState? value, context) {
          final LoginNavigator _loginNavigator = AppInjector.I.get();
          final HomeNavigator _homeNavigator = AppInjector.I.get();
          switch (value?.status) {
            case AuthenticationStatus.unauthenticated:
              if (bloc.navigator?.context != null) {
                _loginNavigator.navigateToRoot(bloc.navigator!.context);
              }
              break;
            case AuthenticationStatus.authenticated:
              if (bloc.navigator?.context != null) {
                _homeNavigator.navigateToRoot(bloc.navigator!.context);
              }
              break;
            default:
              break;
          }
        }, listenWhen: (state) => true);

        return child ?? Container();
      });
    };
  }
}
