import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:login/src/ui/cubit/login_cubit.dart';

import 'cubit/login_state.dart';

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = useBloc<LoginCubit>();
    useBlocListener<LoginCubit, LoginState>(
      _cubit,
      (_, state, _context) {
        if (state.status.isSubmissionFailure) {
          debugPrint('state==>${state.status}');
          debugPrint('message=>${state.message}');
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
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _UsernameInput(
                cubit: _cubit,
              ),
              const Padding(padding: EdgeInsets.all(12)),
              _PasswordInput(
                cubit: _cubit,
              ),
              const Padding(padding: EdgeInsets.all(12)),
              _LoginButton(
                cubit: _cubit,
              ),
            ],
          ),
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

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: cubit.mapUsernameChangedToState,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'username',
        errorText: state.username.invalid ? 'invalid username' : null,
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
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: cubit.mapPasswordChangedToState,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: state.password.invalid ? 'invalid password' : null,
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
    return state.status.isSubmissionInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            onPressed: state.status.isValidated
                ? () {
                    _analyticsLogger.logEvent('login_submit_click');
                    cubit.mapLoginSubmittedToState();
                  }
                : null,
            child: const Text('Login'),
          );
  }
}
