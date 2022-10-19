import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:squid/data/models/note_model.dart';
import 'package:squid/data/repositories/note_repository.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';

void main() {
  const String userId = 'test-user-id';
  late NoteRepository repository;
  late FakeFirebaseFirestore firestore;
  const Note note0 = Note(id: 'note-0', title: 'Note 0', color: Colors.lightBlue, textColor: Colors.black);
  const Note note1 = Note(id: 'note-1', title: 'Note 1', color: Colors.blue, textColor: Colors.white);

  setUp(() async {
    firestore = FakeFirebaseFirestore();
    Dependencies().configureDefault(useMocks: true).configure(firestore: firestore);

    repository = NoteRepository();

    await firestore.collection('users/$userId/notes').doc(note0.id).set(note0.toJson());
    await firestore.collection('users/$userId/notes').doc(note1.id).set(note1.toJson());
  });

  tearDownAll(() async {
    await firestore.collection('users/$userId/notes').doc(note0.id).set(note0.toJson());
    await firestore.collection('users/$userId/notes').doc(note1.id).set(note1.toJson());
  });

  test('get notes finds all notes', () async {
    List<Note> notes = await repository.getNotesForUser(userId: userId);

    expect(notes.length == 2, isTrue);
    expect(notes[0] == note0, isTrue);
    expect(notes[0].title == note0.title, isTrue);
    expect(notes[0].color.value == note0.color.value, isTrue);
    expect(notes[0].textColor.value == note0.textColor.value, isTrue);

    expect(notes[1] == note1, isTrue);
  });

  test('create note populates a new note', () async {
    String title = 'Test Note';
    Color color = Colors.lightBlue;
    Color textColor = Colors.black;

    String noteId = await repository.createNoteForUser(
      userId: userId,
      title: title,
      color: color,
      textColor: textColor,
    );

    Map values = json.decode(firestore.dump());
    Map notes = values['users'][userId]['notes'];
    expect(notes.values.length == 3, isTrue);

    Map note = notes[noteId];
    expect(note['id'] == noteId, isTrue);
    expect(note['title'] == title, isTrue);
    expect(note['color'] == color.hex(), isTrue);
    expect(note['textColor'] == textColor.hex(), isTrue);

    firestore.collection('users/$userId/notes').doc(noteId).delete();
  });

  test('update notes applies all updates', () async {
    await repository.updateNoteForUser(userId: userId, noteId: note0.id, title: 'New Note 0');
    await repository.updateNoteForUser(userId: userId, noteId: note1.id, color: Colors.green, textColor: Colors.red);

    Map values = json.decode(firestore.dump());
    Map notes = values['users'][userId]['notes'];
    expect(notes.values.length == 2, isTrue);

    Map first = notes[note0.id];
    Map second = notes[note1.id];

    expect(first['id'] == note0.id, isTrue);
    expect(first['title'] == 'New Note 0', isTrue);
    expect(first['color'] == note0.color.hex(), isTrue);
    expect(first['textColor'] == note0.textColor.hex(), isTrue);

    expect(second['id'] == note1.id, isTrue);
    expect(second['title'] == note1.title, isTrue);
    expect(second['color'] == Colors.green.hex(), isTrue);
    expect(second['textColor'] == Colors.red.hex(), isTrue);
  });
}
