part of '../auth_bloc.dart';

abstract class AuthState extends Equatable {
  AuthState();
}

class AuthUninitialized extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthRegisterSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoginSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}
