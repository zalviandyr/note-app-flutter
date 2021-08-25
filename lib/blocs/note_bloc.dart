import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  NoteBloc(this._snackbarCubit) : super(NoteUninitialized());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    try {
      if (event is NoteAdd) {
        yield NoteLoading();

        User user = _auth.currentUser!;
        Map<String, String> note = event.note.toJson();

        DatabaseReference userRef = _database.reference().child(user.uid);
        userRef.push().set(note);

        _snackbarCubit.setInfo(SnackbarWord.addNoteSuccess);

        yield NoteAddSuccess();
      }

      if (event is NoteUpdate) {
        yield NoteLoading();

        User user = _auth.currentUser!;
        String key = event.note.key!;
        Map<String, String> note = event.note.toJson();

        DatabaseReference userRef = _database.reference().child(user.uid);
        userRef.child(key).set(note);

        _snackbarCubit.setInfo(SnackbarWord.updateNoteSuccess);

        yield NoteUpdateSuccess();
      }

      if (event is NoteDelete) {
        yield NoteLoading();

        User user = _auth.currentUser!;
        String key = event.note.key!;

        DatabaseReference userRef = _database.reference().child(user.uid);
        userRef.child(key).remove();

        _snackbarCubit.setInfo(SnackbarWord.deleteNoteSuccess);

        this.add(NoteFetch()); // re-fetch
      }

      if (event is NoteFetch) {
        yield NoteLoading();

        User user = _auth.currentUser!;
        DatabaseReference userRef = _database.reference().child(user.uid);

        DataSnapshot snapshot = await userRef.once();
        List<Note> notes = Note.fromJson(snapshot.value)
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

        yield NoteFetchSuccess(notes: notes);
      }
    } catch (err) {
      print(err);

      _snackbarCubit.setError(SnackbarWord.globalError);

      yield NoteError();
    }
  }
}
