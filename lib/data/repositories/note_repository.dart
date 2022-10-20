import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:squid/data/models/note_model.dart';
import 'package:squid/errors/note_error.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository() : _firestore = Dependencies().firestore;

  Future<List<Note>> getNotesForUser({required String userId}) async {
    try {
      CollectionReference collection = _getCollection(userId: userId);
      QuerySnapshot<Object?> notes = await collection.get();
      return List<Note>.from(notes.docs.map((e) => e.data()! as Note));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'storage/object-not-found':
          throw NoteError.notFound;
        case 'storage/unauthorized':
          throw NoteError.unauthorized;
        default:
          throw NoteError(errorCode: 'get-notes-for-user', message: e.message);
      }
    } catch (e) {
      throw NoteError(errorCode: 'get-notes-for-user', message: e.toString());
    }
  }

  Future<String> createNoteForUser({
    required String userId,
    required String title,
    required Color color,
    required Color textColor,
  }) async {
    try {
      CollectionReference collection = _getCollection(userId: userId);
      String id = collection.doc().id;
      await collection.doc(id).set(Note(id: id, title: title, color: color, textColor: textColor));
      return id;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'storage/unauthorized':
          throw NoteError.unauthorized;
        default:
          throw NoteError(errorCode: 'create-note-for-user', message: e.message);
      }
    } catch (e) {
      throw NoteError(errorCode: 'create-note-for-user', message: e.toString());
    }
  }

  Future updateNoteForUser({
    required String userId,
    required String noteId,
    String? title,
    Color? color,
    Color? textColor,
  }) async {
    try {
      CollectionReference collection = _getCollection(userId: userId, convert: false);
      await collection.doc(noteId).update(Note.frame(title: title, color: color, textColor: textColor));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'storage/object-not-found':
          throw NoteError.notFound;
        case 'storage/unauthorized':
          throw NoteError.unauthorized;
        default:
          throw NoteError(errorCode: 'update-note-for-user', message: e.message);
      }
    } catch (e) {
      throw NoteError(errorCode: 'update-note-for-user', message: e.toString());
    }
  }

  Future deleteNoteForUser({required String userId, required String noteId}) async {
    try {
      CollectionReference collection = _getCollection(userId: userId);
      await collection.doc(noteId).delete();
      return noteId;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'storage/object-not-found':
          throw NoteError.notFound;
        case 'storage/unauthorized':
          throw NoteError.unauthorized;
        default:
          throw NoteError(errorCode: 'delete-note-for-user', message: e.message);
      }
    } catch (e) {
      throw NoteError(errorCode: 'delete-note-for-user', message: e.toString());
    }
  }

  CollectionReference _getCollection({required String userId, bool convert = true}) {
    CollectionReference collection = _firestore.collection('users/$userId/notes');
    if (!convert) return collection;

    return collection.withConverter<Note>(
      fromFirestore: (snapshot, options) => Note.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }
}
