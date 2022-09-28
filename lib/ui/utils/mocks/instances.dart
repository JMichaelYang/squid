import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class Mocks {
  static final user = MockUser(
    isAnonymous: false,
    uid: 'test-user-001',
    email: 'test@tester.com',
    displayName: 'Test Account',
  );
}
