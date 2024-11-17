part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable  {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent {
  final String password;
  final String email;
  LoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
