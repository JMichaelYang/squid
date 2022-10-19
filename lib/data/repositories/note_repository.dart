import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository() : _firestore = Dependencies().firestore;
}
