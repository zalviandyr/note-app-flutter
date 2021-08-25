part of '../note_bloc.dart';

abstract class NoteEvent extends Equatable {
  NoteEvent();
}

class NoteAdd extends NoteEvent {
  final Note note;

  NoteAdd({required this.note});

  @override
  List<Object?> get props => [note];
}

class NoteUpdate extends NoteEvent {
  final Note note;

  NoteUpdate({required this.note});

  @override
  List<Object?> get props => [note];
}

class NoteDelete extends NoteEvent {
  final Note note;

  NoteDelete({required this.note});

  @override
  List<Object?> get props => [note];
}

class NoteFetch extends NoteEvent {
  @override
  List<Object?> get props => [];
}
