import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:squid/errors/squid_error.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';

import '../models/note_model.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository() : _firestore = Dependencies().firestore;

  Future<List<Note>> getNotesForUser({required String userId}) async {
    CollectionReference collection = _firestore
        .collection(
          'users/$userId/notes',
        )
        .withConverter<Note>(
          fromFirestore: ((snapshot, options) {
            return Note.fromJson(snapshot.data()!);
          }),
          toFirestore: ((value, options) => value.toJson()),
        );

    try {
      QuerySnapshot<Object?> notes = await collection.get();
      return List<Note>.from(notes.docs.map((e) => e.data()! as Note));
    } catch (e) {
      throw SquidError(namespace: 'notes', errorCode: 'get-notes-unknown', message: e.toString());
    }
  }
}
