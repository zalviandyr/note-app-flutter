part of '../note_bloc.dart';

abstract class NoteState extends Equatable {
  NoteState();
}

class NoteUninitialized extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteError extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteAddSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteUpdateSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteFetchSuccess extends NoteState {
  final List<Note> notes;

  NoteFetchSuccess({required this.notes});

  @override
  List<Object?> get props => [notes];
}
