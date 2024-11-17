part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class LodingState extends AuthenticationState {}

class LoginedState extends AuthenticationState {
  final List<dynamic> listOfObject;

  LoginedState({required this.listOfObject});
  @override
  List<Object> get props => [listOfObject];
}

class ErrorState extends AuthenticationState {
  final String message;
  ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
