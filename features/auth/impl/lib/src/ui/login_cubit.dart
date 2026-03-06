import 'package:auth/src/models/models.dart';
import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';
import 'package:flutter/widgets.dart';

import '../repository/auth_repository.dart';
import 'login_contract.dart';

///author: lty
///Time: 2022/06/02
///Description: Refactored to MVI and Repository Pattern

@injectable
class LoginCubit extends BaseMviCubit<LoginIntent, LoginState, LoginSingleEvent> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  @override
  void onIntent(LoginIntent intent) {
    intent.when(
      usernameChanged: _onUsernameChanged,
      passwordChanged: _onPasswordChanged,
      loginSubmitted: _onLoginSubmitted,
    );
  }

  void _onUsernameChanged(String username) {
    final _username = Username.dirty(username);
    emit(
      state.copyWith(
        username: _username,
        isValid: Formz.validate([state.password, _username]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(String password) {
    final _password = Password.dirty(password);
    emit(
      state.copyWith(
        password: _password,
        isValid: Formz.validate([_password, state.username]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onLoginSubmitted() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final authUser = await _authRepository.loginByPwd(
          state.username.value,
          state.password.value,
        );
        
        if (authUser != null) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
          emitEffect(const LoginSingleEvent.loginSuccess());
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Login failed'));
          emitEffect(const LoginSingleEvent.loginFailure('Login failed'));
        }
      } catch (ex) {
        debugPrint('Login error: $ex');
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: ex.toString()));
        emitEffect(LoginSingleEvent.loginFailure(ex.toString()));
      }
    }
  }
}
