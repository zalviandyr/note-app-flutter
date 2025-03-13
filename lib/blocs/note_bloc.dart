import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/models/models.dart';

part 'event_states/note_event.dart';
part 'event_states/note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SnackbarCubit _snackbarCubit;

  NoteBloc(this._snackbarCubit) : super(NoteUninitialized()) {
    on<NoteAdd>(_onAddNote);
    on<NoteUpdate>(_onUpdateNote);
    on<NoteDelete>(_onDeleteNote);
    on<NoteFetch>(_onFetchNotes);
  }

  Future<void> _onAddNote(NoteAdd event, Emitter<NoteState> emit) async {
    await _handleNoteOperation(
      emit,
      () async {
        User user = _auth.currentUser!;
        DatabaseReference userRef = _database.ref().child(user.uid);
        await userRef.push().set(event.note.toJson());
      },
      successMessage: SnackbarWord.addNoteSuccess,
      onSuccess: () => emit(NoteAddSuccess()),
    );
  }

  Future<void> _onUpdateNote(NoteUpdate event, Emitter<NoteState> emit) async {
    await _handleNoteOperation(
      emit,
      () async {
        User user = _auth.currentUser!;
        DatabaseReference userRef = _database.ref().child(user.uid);
        await userRef.child(event.note.key!).set(event.note.toJson());
      },
      successMessage: SnackbarWord.updateNoteSuccess,
      onSuccess: () => emit(NoteUpdateSuccess()),
    );
  }

  Future<void> _onDeleteNote(NoteDelete event, Emitter<NoteState> emit) async {
    await _handleNoteOperation(
      emit,
      () async {
        User user = _auth.currentUser!;
        DatabaseReference userRef = _database.ref().child(user.uid);
        await userRef.child(event.note.key!).remove();
      },
      successMessage: SnackbarWord.deleteNoteSuccess,
      onSuccess: () => add(NoteFetch()), // Re-fetch data
    );
  }

  Future<void> _onFetchNotes(NoteFetch event, Emitter<NoteState> emit) async {
    try {
      emit(NoteLoading());
      User user = _auth.currentUser!;
      DatabaseReference userRef = _database.ref().child(user.uid);

      DataSnapshot snapshot = await userRef.get();
      if (snapshot.value != null) {
        List<Note> notes = Note.fromJson(snapshot.value)
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
        emit(NoteFetchSuccess(notes: notes));
      } else {
        emit(NoteFetchSuccess(notes: []));
      }
    } catch (err, trace) {
      onError(err, trace);

      _handleError(err, emit);
    }
  }

  Future<void> _handleNoteOperation(
    Emitter<NoteState> emit,
    Future<void> Function() operation, {
    required String successMessage,
    required VoidCallback onSuccess,
  }) async {
    try {
      emit(NoteLoading());
      await operation();
      _snackbarCubit.setInfo(successMessage);
      onSuccess();
    } catch (err, trace) {
      onError(err, trace);

      _handleError(err, emit);
    }
  }

  void _handleError(dynamic err, Emitter<NoteState> emit) {
    _snackbarCubit.setError(SnackbarWord.globalError);
    emit(NoteError());
  }
}
