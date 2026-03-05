import 'package:auth/src/models/models.dart';
import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';
import 'package:flutter/widgets.dart';

import 'login_state.dart';

///author: lty
///Time: 2022/06/02
///Description:

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void mapUsernameChangedToState(String username) {
    final _username = Username.dirty(username);
    emit(
      state.copyWith(
        username: _username,
        isValid: Formz.validate([state.password, _username]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void mapPasswordChangedToState(String password) {
    final _password = Password.dirty(password);
    emit(
      state.copyWith(
        password: _password,
        isValid: Formz.validate([_password, state.username]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> mapLoginSubmittedToState() async {
    HttpClient _httpClient = GetIt.I.get<HttpClient>();
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        var result = await _httpClient.post(
          '/api/loginByPwd',
          body: {'userName': state.username.value, 'password': state.password.value},
        );
        debugPrint('Login result: ${result.ok}, error: ${result.error}, data: ${result.result}');
        if (result.ok) {
          // Consume the mock JSON data rather than hardcoding it
          var authUser = AuthUser.fromJson(result.result);
          await SessionManager.defaultManager.setUser(authUser);
          await SessionManager.defaultManager.setUserToken(authUser.token);
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, message: result.error?.message));
        }
      } catch (ex) {
        debugPrint('Login error: $ex');
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: ex.toString()));
      }
    }
  }
}
