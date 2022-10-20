import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squid/blocs/note/note_event.dart';
import 'package:squid/blocs/note/note_state.dart';
import 'package:squid/data/models/note_model.dart';
import 'package:squid/data/repositories/note_repository.dart';
import 'package:squid/errors/squid_error.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;
  final String _userId;

  NoteBloc({required NoteRepository noteRepository, required String userId})
      : _noteRepository = noteRepository,
        _userId = userId,
        super(NotesLoadingState()) {
    on<NotesLoadEvent>((event, emit) async {
      emit(NotesLoadingState());

      try {
        List<Note> notes = await _noteRepository.getNotesForUser(userId: _userId);
        emit(NotesLoadedState(notes));
      } on SquidError catch (e) {
        emit(NoteErrorState(e));
      }
    });

    on<NoteAddEvent>((event, emit) async {
      emit(NotesLoadingState());

      try {
        await _noteRepository.createNoteForUser(
          userId: userId,
          title: event.title,
          color: event.color,
          textColor: event.textColor,
        );

        List<Note> notes = await _noteRepository.getNotesForUser(userId: _userId);
        emit(NotesLoadedState(notes));
      } on SquidError catch (e) {
        emit(NoteErrorState(e));
      }
    });

    on<NoteUpdateEvent>((event, emit) async {
      emit(NotesLoadingState());

      try {
        await _noteRepository.updateNoteForUser(
          userId: userId,
          noteId: event.id,
          title: event.title,
          color: event.color,
          textColor: event.textColor,
        );

        List<Note> notes = await _noteRepository.getNotesForUser(userId: _userId);
        emit(NotesLoadedState(notes));
      } on SquidError catch (e) {
        emit(NoteErrorState(e));
      }
    });

    on<NoteDeleteEvent>((event, emit) async {
      emit(NotesLoadingState());

      try {
        await _noteRepository.deleteNoteForUser(userId: userId, noteId: event.id);

        List<Note> notes = await _noteRepository.getNotesForUser(userId: _userId);
        emit(NotesLoadedState(notes));
      } on SquidError catch (e) {
        emit(NoteErrorState(e));
      }
    });

    on<NoteErrorEvent>((event, emit) async {
      emit(NoteErrorState(event.error));
    });
  }
}
