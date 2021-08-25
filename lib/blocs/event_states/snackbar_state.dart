part of '../snackbar_cubit.dart';

abstract class SnackbarState extends Equatable {
  SnackbarState();
}

class SnackbarUninitialized extends SnackbarState {
  @override
  List<Object?> get props => [];
}

class SnackbarInfo extends SnackbarState {
  final String message;

  SnackbarInfo({required this.message});

  @override
  List<Object?> get props => [message];
}

class SnackbarError extends SnackbarState {
  final String message;

  SnackbarError({required this.message});

  @override
  List<Object?> get props => [message];
}
