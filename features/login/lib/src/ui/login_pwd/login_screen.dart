import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:login/src/localization/login_localizations.dart';
import 'package:login/src/ui/login_pwd/login_cubit.dart';
import 'package:login/src/ui/login_pwd/login_state.dart';
import 'package:login/src/widget/fade_animation.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = useBloc<LoginCubit>();
    useBlocListener<LoginCubit, LoginState>(
      _cubit,
      (_, state, _context) {
        if (state.status.isFailure) {
          try {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
          } catch (ex, stack) {
            debugPrint('$ex');
            debugPrint('$stack');
          }
        }
      },
      listenWhen: (state) => true,
    );
    final _intl = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      '${_intl?.login_screen_login}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      '${_intl?.login_screen_title}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  child: _UsernameInput(
                                    cubit: _cubit,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  child: _PasswordInput(
                                    cubit: _cubit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.5,
                          Text(
                            '${_intl?.login_screen_forgot_pwd}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.6,
                          _LoginButton(
                            cubit: _cubit,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                          1.7,
                          Text(
                            '${_intl?.login_screen_other_login_type}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(
                                1.8,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Facebook',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: FadeAnimation(
                                1.9,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Github',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends HookWidget {
  final LoginCubit cubit;

  const _UsernameInput({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginState state = useBlocBuilder<LoginCubit, LoginState>(
      cubit,
    );
    final _intl = AppLocalizations.of(context);
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: cubit.mapUsernameChangedToState,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: '${_intl?.login_screen_account_hint}',
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
        errorText: state.username.displayError != null ? '请输入正确的手机号' : null,
      ),
    );
  }
}

class _PasswordInput extends HookWidget {
  final LoginCubit cubit;

  const _PasswordInput({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginState state = useBlocBuilder<LoginCubit, LoginState>(
      cubit,
    );
    final _intl = AppLocalizations.of(context);

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: cubit.mapPasswordChangedToState,
      obscureText: true,
      decoration: InputDecoration(
        hintText: '${_intl?.login_screen_password_hint}',
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
        errorText: state.password.displayError != null ? '请输入正确的密码' : null,
      ),
    );
  }
}

class _LoginButton extends HookWidget {
  final LoginCubit cubit;
  final AnalyticsLogger _analyticsLogger = AppInjector.I.get();

  _LoginButton({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginState state = useBlocBuilder<LoginCubit, LoginState>(
      cubit,
    );
    final _intl = AppLocalizations.of(context);

    return InkWell(
      key: const Key('loginForm_continue_raisedButton'),
      onTap: state.isValid
          ? () {
              _analyticsLogger.logEvent('login_submit_click');
              cubit.mapLoginSubmittedToState();
            }
          : null,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: state.isValid ? Colors.orange[900] : Colors.grey[300],
        ),
        child: Center(
          child: state.status.isInProgress
              ? const CircularProgressIndicator()
              : Text(
                  '${_intl?.login_screen_login}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
