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
        status: Formz.validate([state.password, _username]),
      ),
    );
  }

  void mapPasswordChangedToState(String password) {
    final _password = Password.dirty(password);
    emit(
      state.copyWith(
        password: _password,
        status: Formz.validate([_password, state.username]),
      ),
    );
  }

  final HttpClient _httpClient = AppInjector.I.get();
  Future<void> mapLoginSubmittedToState() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var result = await _httpClient.post('/api/loginByPwd', body: {'userName': state.username.value, 'password': state.password.value});
        if (result.ok) {
          await _authenticationRepository.logIn(User.fromJson(result.result));
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure, message: result.error?.message));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
