part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String username;
  final String email;
  final String password;

  const RegisterEvent({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, username, email, password];
}

class GoogleLoginEvent extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}
