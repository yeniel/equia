part of 'login_bloc.dart';

// TODO: Status?
class LoginState extends Equatable {
  const LoginState(
    // {this.status = LoginStatus.pure}
  );

  // final LoginStatus status;

  LoginState copyWith({
    // LoginStatus? status,
    Exception? error,
  }) {
    return const LoginState(
      // status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => []; // [status]
}
