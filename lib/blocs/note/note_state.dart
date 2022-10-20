import 'package:flutter/foundation.dart';
import 'package:squid/data/models/note_model.dart';
import 'package:squid/errors/squid_error.dart';

@immutable
abstract class NoteState {}

@immutable
class NotesLoadingState extends NoteState {}

@immutable
class NoteAddedState extends NoteState {
  final String addedId;

  NoteAddedState(this.addedId);
}

@immutable
class NoteDeletedState extends NoteState {
  final String deletedId;

  NoteDeletedState(this.deletedId);
}

@immutable
class NotesLoadedState extends NoteState {
  final List<Note> notes;

  NotesLoadedState(this.notes);
}

@immutable
class NoteErrorState extends NoteState {
  final SquidError error;

  NoteErrorState(this.error);
}
