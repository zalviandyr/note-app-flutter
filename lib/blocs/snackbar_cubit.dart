import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_states/snackbar_state.dart';

class SnackbarCubit extends Cubit<SnackbarState> {
  SnackbarCubit() : super(SnackbarUninitialized());

  void setError(String message) {
    emit(SnackbarError(message: message));
    emit(SnackbarUninitialized()); // to reset
  }

  void setInfo(String message) {
    emit(SnackbarInfo(message: message));
    emit(SnackbarUninitialized()); // to reset
  }
}
