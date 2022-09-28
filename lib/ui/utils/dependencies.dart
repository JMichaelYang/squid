import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class Dependencies {
  static final Dependencies _instance = Dependencies._init();

  static bool useMockFirebaseAuth = true;
  late FirebaseAuth _firebaseAuth;
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Dependencies._init() {
    configure();
  }

  factory Dependencies() => _instance;

  void configure({bool? mockFirebaseAuth}) {
    mockFirebaseAuth ??= useMockFirebaseAuth;
    _firebaseAuth = mockFirebaseAuth ? MockFirebaseAuth(mockUser: MockUser()) : FirebaseAuth.instance;
  }
}
