part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.errMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  List<Object?> get props => [status, errMessage];
}
