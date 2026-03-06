import 'package:common/common.dart';
import 'package:flutter/material.dart';

import '../localization/auth_localizations.dart';
import '../widget/fade_animation.dart';
import 'login_contract.dart';
import 'login_cubit.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _intl = AppLocalizations.of(context);
    final _cubit = useBloc<LoginCubit>();
    final state = useBlocBuilder<LoginCubit, LoginState>(_cubit);
    final _analyticsLogger = GetIt.I<AnalyticsLogger>();
    useEffect(() {
      final subscription = _cubit.effectStream.listen((effect) {
        effect.when(
          loginSuccess: () {},
          loginFailure: (message) {
            try {
              final translatedMsg = message == 'Login failed' ? (_intl?.login_screen_error_failed ?? message) : message;
              Fluttertoast.showToast(
                msg: translatedMsg,
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
          },
        );
      });
      return subscription.cancel;
    }, [_cubit]);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.orange.shade900, Colors.orange.shade800, Colors.orange.shade400],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text('${_intl?.login_screen_login}', style: const TextStyle(color: Colors.white, fontSize: 40)),
                  ),
                  const SizedBox(height: 10),
                  FadeAnimation(
                    1.3,
                    Text('${_intl?.login_screen_title}', style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 60),
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
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                  ),
                                  child: _UsernameInput(
                                    errorText: state.username.displayError != null ? _intl?.login_screen_username_error : null,
                                    onChanged: (val) => _cubit.onIntent(LoginIntent.usernameChanged(val)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                  ),
                                  child: _PasswordInput(
                                    errorText: state.password.displayError != null ? _intl?.login_screen_password_error : null,
                                    onChanged: (val) => _cubit.onIntent(LoginIntent.passwordChanged(val)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        FadeAnimation(
                          1.5,
                          Text('${_intl?.login_screen_forgot_pwd}', style: const TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(height: 40),
                        FadeAnimation(
                          1.6,
                          _LoginButton(
                            isValid: state.isValid,
                            isLoading: state.status.isInProgress,
                            onTap: () {
                              _analyticsLogger.logEvent('login_submit_click');
                              _cubit.onIntent(const LoginIntent.loginSubmitted());
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                        FadeAnimation(
                          1.7,
                          Text('${_intl?.login_screen_other_login_type}', style: const TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(height: 30),
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
                                  child: Center(
                                    child: Text(
                                      _intl?.login_screen_facebook ?? 'Facebook',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: FadeAnimation(
                                1.9,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _intl?.login_screen_github ?? 'Github',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final String? errorText;
  final ValueChanged<String> onChanged;

  const _UsernameInput({Key? key, this.errorText, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _intl = AppLocalizations.of(context);
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: onChanged,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: '${_intl?.login_screen_account_hint}',
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
        errorText: errorText,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final String? errorText;
  final ValueChanged<String> onChanged;

  const _PasswordInput({Key? key, this.errorText, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _intl = AppLocalizations.of(context);

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: onChanged,
      obscureText: true,
      decoration: InputDecoration(
        hintText: '${_intl?.login_screen_password_hint}',
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
        errorText: errorText,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isValid;
  final bool isLoading;
  final VoidCallback? onTap;

  const _LoginButton({
    Key? key,
    required this.isValid,
    required this.isLoading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _intl = AppLocalizations.of(context);

    return InkWell(
      key: const Key('loginForm_continue_raisedButton'),
      onTap: isValid ? onTap : null,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isValid ? Colors.orange[900] : Colors.grey[300],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  '${_intl?.login_screen_login}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
