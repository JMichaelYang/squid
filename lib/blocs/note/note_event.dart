import 'package:flutter/material.dart';
import 'package:squid/errors/squid_error.dart';

@immutable
abstract class NoteEvent {}

@immutable
class NotesLoadEvent extends NoteEvent {}

@immutable
class NoteAddEvent extends NoteEvent {
  final String title;
  final Color color;
  final Color textColor;

  NoteAddEvent(this.title, this.color, this.textColor);
}

@immutable
class NoteUpdateEvent extends NoteEvent {
  final String id;
  final String? title;
  final Color? color;
  final Color? textColor;

  NoteUpdateEvent(this.id, {this.title, this.color, this.textColor});
}

@immutable
class NoteDeleteEvent extends NoteEvent {
  final String id;

  NoteDeleteEvent(this.id);
}

@immutable
class NoteErrorEvent extends NoteEvent {
  final SquidError error;

  NoteErrorEvent(this.error);
}
