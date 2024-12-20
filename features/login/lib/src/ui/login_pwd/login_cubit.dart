import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:login/src/models/models.dart';
import 'package:network/network.dart';

import 'login_state.dart';

///author: lty
///Time: 2022/06/02
///Description:

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final AuthenticationRepository _authenticationRepository = AppInjector.I.get();

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

  final HttpClient _httpClient = AppInjector.I.get();
  Future<void> mapLoginSubmittedToState() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        var result = await _httpClient.post('/api/loginByPwd', body: {'userName': state.username.value, 'password': state.password.value});
        if (!result.ok) {
          await _authenticationRepository.logIn(User.fromJson(const {
            'access_token': 'asasas111',
            'userInfo': {'userId': '1212', 'userName': 'ceshi'}
          }));
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, message: result.error?.message));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
