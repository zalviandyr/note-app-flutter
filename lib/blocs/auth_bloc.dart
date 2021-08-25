import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';

part 'event_states/auth_event.dart';
part 'event_states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late SnackbarCubit _snackbarCubit;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc(this._snackbarCubit) : super(AuthUninitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is AuthRegister) {
        yield AuthLoading();

        await _auth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);

        _snackbarCubit.setInfo(SnackbarWord.registerSuccess);

        yield AuthRegisterSuccess();
      }

      if (event is AuthLogin) {
        yield AuthLoading();

        await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        _snackbarCubit.setInfo(SnackbarWord.loginSuccess);

        yield AuthLoginSuccess();
      }
    } on FirebaseAuthException catch (err) {
      print(err);

      if (err.code == 'invalid-email')
        _snackbarCubit.setError(SnackbarWord.invalidEmail);
      else if (err.code == 'weak-password')
        _snackbarCubit.setError(SnackbarWord.weakPassword);
      else if (err.code == 'email-already-in-use')
        _snackbarCubit.setError(SnackbarWord.emailAlreadyInUse);
      else if (err.code == 'user-not-found')
        _snackbarCubit.setError(SnackbarWord.userNotFound);
      else if (err.code == 'wrong-password')
        _snackbarCubit.setError(SnackbarWord.wrongPassword);

      yield AuthError();
    } catch (err) {
      print(err);

      _snackbarCubit.setError(SnackbarWord.globalError);

      yield AuthError();
    }
  }
}
