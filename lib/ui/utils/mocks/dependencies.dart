import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:squid/ui/utils/mocks/instances.dart';

import 'mock_google_sign_in.dart';

class Dependencies {
  static final Dependencies _instance = Dependencies._init();

  late FirebaseAuth _firebaseAuth;
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  late GoogleSignIn _googleSignIn;
  GoogleSignIn get googleSignIn => _googleSignIn;

  late FirebaseFirestore _firestore;
  FirebaseFirestore get firestore => _firestore;

  Dependencies._init();

  factory Dependencies() => _instance;

  void configure({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  }) {
    _firebaseAuth = firebaseAuth ?? _firebaseAuth;
    _googleSignIn = googleSignIn ?? _googleSignIn;
    _firestore = firestore ?? _firestore;
  }

  void configureDefault({bool mockFirebaseAuth = false, bool mockGoogleSignIn = false, bool mockFirestore = false}) {
    _firebaseAuth = mockFirebaseAuth ? MockFirebaseAuth(mockUser: Mocks.user) : FirebaseAuth.instance;
    _googleSignIn = mockGoogleSignIn ? MockGoogleSignIn() : GoogleSignIn();
    _firestore = mockFirestore ? FakeFirebaseFirestore() : FirebaseFirestore.instance;
  }
}
