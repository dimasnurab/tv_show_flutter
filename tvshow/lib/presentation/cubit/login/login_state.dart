part of 'login_cubit.dart';

enum LoginStatusState {
  done,
  fail,
  loaded,
  initial,
  setSessionDone,
}

class LoginState extends Equatable {
  const LoginState({
    this.requestToken = '',
    this.statusState = LoginStatusState.initial,
  });
  final String requestToken;
  final LoginStatusState statusState;

  LoginState copyWith({
    String? requestToken,
    LoginStatusState? statusState,
  }) =>
      LoginState(
        requestToken: requestToken ?? this.requestToken,
        statusState: statusState ?? this.statusState,
      );
  @override
  List<Object> get props => [statusState, requestToken];
}
