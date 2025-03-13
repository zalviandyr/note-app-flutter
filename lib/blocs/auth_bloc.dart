import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';

part 'event_states/auth_event.dart';
part 'event_states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SnackbarCubit _snackbarCubit;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc(this._snackbarCubit) : super(AuthUninitialized()) {
    on<AuthRegister>(_onRegister);
    on<AuthLogin>(_onLogin);
  }

  Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    await _handleAuth(
      emit,
      () async => _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ),
      onSuccess: () {
        _snackbarCubit.setInfo(SnackbarWord.registerSuccess);
        emit(AuthRegisterSuccess());
      },
    );
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    await _handleAuth(
      emit,
      () async => _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ),
      onSuccess: () {
        _snackbarCubit.setInfo(SnackbarWord.loginSuccess);
        emit(AuthLoginSuccess());
      },
    );
  }

  Future<void> _handleAuth(
    Emitter<AuthState> emit,
    Future<void> Function() authFunction, {
    required VoidCallback onSuccess,
  }) async {
    try {
      emit(AuthLoading());
      await authFunction();
      onSuccess();
    } on FirebaseAuthException catch (err, trace) {
      onError(err, trace);

      _handleFirebaseAuthError(err);
      emit(AuthError());
    } catch (err, trace) {
      onError(err, trace);

      _snackbarCubit.setError(SnackbarWord.globalError);
      emit(AuthError());
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException err) {
    final errorMapping = {
      'invalid-email': SnackbarWord.invalidEmail,
      'weak-password': SnackbarWord.weakPassword,
      'email-already-in-use': SnackbarWord.emailAlreadyInUse,
      'user-not-found': SnackbarWord.userNotFound,
      'wrong-password': SnackbarWord.wrongPassword,
    };

    _snackbarCubit.setError(errorMapping[err.code] ?? SnackbarWord.globalError);
  }
}
