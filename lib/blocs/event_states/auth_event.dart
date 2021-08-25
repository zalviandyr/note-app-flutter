part of '../auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;

  AuthRegister({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
