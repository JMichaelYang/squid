import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:squid/ui/utils/mocks/dependencies.dart';

class SectionRepository {
  final FirebaseFirestore _firestore;

  SectionRepository() : _firestore = Dependencies().firestore;
}
